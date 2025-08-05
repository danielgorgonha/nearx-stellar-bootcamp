#!/bin/bash

# 🚀 Script de Teste Automatizado para Contrato Token na Testnet
# Autor: NearX Stellar Bootcamp
# Versão: 1.0

set -e  # Parar em caso de erro

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para log colorido
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Verificar se o Soroban CLI está instalado
check_soroban() {
    if ! command -v soroban &> /dev/null; then
        log_error "Soroban CLI não encontrado. Instale primeiro: https://soroban.stellar.org/docs/getting-started/setup"
        exit 1
    fi
    log_success "Soroban CLI encontrado"
}

# Verificar configuração da testnet
check_testnet_config() {
    log_info "Verificando configuração da testnet..."
    
    # Verificar se a rede testnet está configurada
    if ! soroban config network ls | grep -q "testnet"; then
        log_warning "Rede testnet não configurada. Configurando..."
        soroban config network add testnet \
            --rpc-url "https://soroban-testnet.stellar.org" \
            --network-passphrase "Test SDF Network ; September 2015"
    fi
    
    # Definir testnet como padrão
    soroban config network set testnet
    log_success "Testnet configurada"
}

# Verificar/criar identidades
setup_identities() {
    log_info "Configurando identidades..."
    
    # Verificar se as identidades existem
    if ! soroban keys ls --network testnet | grep -q "testnet-bob"; then
        log_info "Criando identidade testnet-bob..."
        soroban keys generate testnet-bob --network testnet
    fi
    
    if ! soroban keys ls --network testnet | grep -q "testnet-alice"; then
        log_info "Criando identidade testnet-alice..."
        soroban keys generate testnet-alice --network testnet
    fi
    
    # Fundar contas
    log_info "Fundando contas..."
    soroban keys fund testnet-bob --network testnet
    soroban keys fund testnet-alice --network testnet
    
    log_success "Identidades configuradas"
}

# Compilar contrato
compile_contract() {
    log_info "Compilando contrato..."
    
    if [ ! -f "target/wasm32v1-none/release/token.wasm" ]; then
        soroban contract build
    else
        log_info "Contrato já compilado"
    fi
    
    log_success "Contrato compilado"
}

# Deploy do contrato
deploy_contract() {
    log_info "Fazendo deploy do contrato..."
    
    CONTRACT_ID=$(soroban contract deploy \
        --wasm target/wasm32v1-none/release/token.wasm \
        --source testnet-bob \
        --network testnet)
    
    echo "CONTRACT_ID=$CONTRACT_ID" > .contract_id
    log_success "Contrato deployado: $CONTRACT_ID"
}

# Inicializar contrato
initialize_contract() {
    log_info "Inicializando contrato..."
    
    if [ ! -f ".contract_id" ]; then
        log_error "Arquivo .contract_id não encontrado. Execute o deploy primeiro."
        exit 1
    fi
    
    source .contract_id
    BOB_ADDRESS=$(soroban keys address testnet-bob)
    
    soroban contract invoke \
        --id $CONTRACT_ID \
        --source testnet-bob \
        --network testnet \
        -- \
        initialize \
        --admin $BOB_ADDRESS \
        --decimal 2 \
        --name RealDigital \
        --symbol DREX
    
    log_success "Contrato inicializado"
}

# Testar metadados
test_metadata() {
    log_info "Testando metadados do token..."
    
    source .contract_id
    BOB_ADDRESS=$(soroban keys address testnet-bob)
    ALICE_ADDRESS=$(soroban keys address testnet-alice)
    
    # Testar nome
    NAME=$(soroban contract invoke --id $CONTRACT_ID --source testnet-bob --network testnet -- name)
    log_info "Nome do token: $NAME"
    
    # Testar símbolo
    SYMBOL=$(soroban contract invoke --id $CONTRACT_ID --source testnet-bob --network testnet -- symbol)
    log_info "Símbolo do token: $SYMBOL"
    
    # Testar decimais
    DECIMALS=$(soroban contract invoke --id $CONTRACT_ID --source testnet-bob --network testnet -- decimals)
    log_info "Decimais: $DECIMALS"
    
    # Testar admin
    ADMIN=$(soroban contract invoke --id $CONTRACT_ID --source testnet-bob --network testnet -- get_admin)
    log_info "Admin: $ADMIN"
    
    log_success "Metadados verificados"
}

# Testar operações de token
test_token_operations() {
    log_info "Testando operações de token..."
    
    source .contract_id
    BOB_ADDRESS=$(soroban keys address testnet-bob)
    ALICE_ADDRESS=$(soroban keys address testnet-alice)
    
    # Mint tokens para alice
    log_info "Mintando 1000 DREX para alice..."
    soroban contract invoke \
        --id $CONTRACT_ID \
        --source testnet-bob \
        --network testnet \
        -- \
        mint \
        --to $ALICE_ADDRESS \
        --amount 1000
    
    # Mint tokens para bob
    log_info "Mintando 500 DREX para bob..."
    soroban contract invoke \
        --id $CONTRACT_ID \
        --source testnet-bob \
        --network testnet \
        -- \
        mint \
        --to $BOB_ADDRESS \
        --amount 500
    
    # Verificar saldos iniciais
    log_info "Verificando saldos iniciais..."
    BOB_BALANCE=$(soroban contract invoke --id $CONTRACT_ID --source testnet-bob --network testnet -- balance --id $BOB_ADDRESS)
    ALICE_BALANCE=$(soroban contract invoke --id $CONTRACT_ID --source testnet-alice --network testnet -- balance --id $ALICE_ADDRESS)
    
    log_info "Saldo de Bob: $BOB_BALANCE DREX"
    log_info "Saldo de Alice: $ALICE_BALANCE DREX"
    
    # Transferência de alice para bob
    log_info "Alice transfere 200 DREX para bob..."
    soroban contract invoke \
        --id $CONTRACT_ID \
        --source testnet-alice \
        --network testnet \
        -- \
        transfer \
        --from $ALICE_ADDRESS \
        --to $BOB_ADDRESS \
        --amount 200
    
    # Verificar saldos após transferência
    log_info "Verificando saldos após transferência..."
    BOB_BALANCE=$(soroban contract invoke --id $CONTRACT_ID --source testnet-bob --network testnet -- balance --id $BOB_ADDRESS)
    ALICE_BALANCE=$(soroban contract invoke --id $CONTRACT_ID --source testnet-alice --network testnet -- balance --id $ALICE_ADDRESS)
    
    log_info "Saldo de Bob: $BOB_BALANCE DREX"
    log_info "Saldo de Alice: $ALICE_BALANCE DREX"
    
    log_success "Operações de token testadas"
}

# Testar approve e transfer_from
test_approve_transfer_from() {
    log_info "Testando approve e transfer_from..."
    
    source .contract_id
    BOB_ADDRESS=$(soroban keys address testnet-bob)
    ALICE_ADDRESS=$(soroban keys address testnet-alice)
    
    # Alice aprova bob para gastar 300 DREX
    log_info "Alice aprova bob para gastar 300 DREX..."
    soroban contract invoke \
        --id $CONTRACT_ID \
        --source testnet-alice \
        --network testnet \
        -- \
        approve \
        --from $ALICE_ADDRESS \
        --to $BOB_ADDRESS \
        --amount 300 \
        --expiration-ledger 1000000
    
    # Verificar allowance
    log_info "Verificando allowance..."
    ALLOWANCE=$(soroban contract invoke --id $CONTRACT_ID --source testnet-bob --network testnet -- allowance --from $ALICE_ADDRESS --spender $BOB_ADDRESS)
    log_info "Allowance de Alice para Bob: $ALLOWANCE DREX"
    
    # Bob transfere 150 DREX de alice
    log_info "Bob transfere 150 DREX de alice..."
    soroban contract invoke \
        --id $CONTRACT_ID \
        --source testnet-bob \
        --network testnet \
        -- \
        transfer_from \
        --from $ALICE_ADDRESS \
        --to $BOB_ADDRESS \
        --amount 150
    
    log_success "Approve e transfer_from testados"
}

# Testar operações de burn
test_burn_operations() {
    log_info "Testando operações de burn..."
    
    source .contract_id
    BOB_ADDRESS=$(soroban keys address testnet-bob)
    ALICE_ADDRESS=$(soroban keys address testnet-alice)
    
    # Bob queima 50 DREX
    log_info "Bob queima 50 DREX..."
    soroban contract invoke \
        --id $CONTRACT_ID \
        --source testnet-bob \
        --network testnet \
        -- \
        burn \
        --from $BOB_ADDRESS \
        --amount 50
    
    # Bob queima 25 DREX de alice usando burn_from
    log_info "Bob queima 25 DREX de alice..."
    soroban contract invoke \
        --id $CONTRACT_ID \
        --source testnet-bob \
        --network testnet \
        -- \
        burn_from \
        --from $ALICE_ADDRESS \
        --amount 25
    
    log_success "Operações de burn testadas"
}

# Verificar saldos finais
check_final_balances() {
    log_info "Verificando saldos finais..."
    
    source .contract_id
    BOB_ADDRESS=$(soroban keys address testnet-bob)
    ALICE_ADDRESS=$(soroban keys address testnet-alice)
    
    BOB_BALANCE=$(soroban contract invoke --id $CONTRACT_ID --source testnet-bob --network testnet -- balance --id $BOB_ADDRESS)
    ALICE_BALANCE=$(soroban contract invoke --id $CONTRACT_ID --source testnet-alice --network testnet -- balance --id $ALICE_ADDRESS)
    
    log_success "Saldo final de Bob: $BOB_BALANCE DREX"
    log_success "Saldo final de Alice: $ALICE_BALANCE DREX"
    
    # Calcular total
    TOTAL=$((BOB_BALANCE + ALICE_BALANCE))
    log_info "Total em circulação: $TOTAL DREX"
}

# Função principal
main() {
    echo "🚀 Iniciando testes do contrato token na testnet..."
    echo "=================================================="
    
    check_soroban
    check_testnet_config
    setup_identities
    compile_contract
    
    # Perguntar se quer fazer deploy ou usar contrato existente
    if [ -f ".contract_id" ]; then
        read -p "Contrato já existe. Usar existente? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Nn]$ ]]; then
            deploy_contract
        else
            log_info "Usando contrato existente"
        fi
    else
        deploy_contract
    fi
    
    initialize_contract
    test_metadata
    test_token_operations
    test_approve_transfer_from
    test_burn_operations
    check_final_balances
    
    echo ""
    echo "🎉 Todos os testes foram executados com sucesso!"
    echo "📊 Resumo:"
    echo "   - Contrato deployado e inicializado"
    echo "   - Metadados verificados"
    echo "   - Operações de token testadas"
    echo "   - Approve/TransferFrom funcionando"
    echo "   - Operações de burn executadas"
    echo ""
    echo "🔗 Contract ID: $(cat .contract_id | cut -d'=' -f2)"
    echo "🌐 Verificar no explorer: https://soroban.stellar.org/"
}

# Executar função principal
main "$@" 