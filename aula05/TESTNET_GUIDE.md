# 🚀 Guia Completo: Testando Contrato Token na Testnet

## 📋 Pré-requisitos

### 1. Configuração da Testnet
```bash
# Configurar rede testnet no Soroban CLI
soroban config network add testnet \
  --rpc-url "https://soroban-testnet.stellar.org" \
  --network-passphrase "Test SDF Network ; September 2015"

# Definir testnet como padrão
soroban config network set testnet
```

### 2. Configurar Aliases para Produtividade
```bash
# Adicione ao seu ~/.zshrc ou ~/.bashrc
alias ska="soroban keys address "
alias skl="soroban keys ls "
alias scd="soroban contract deploy "
alias sci="soroban contract invoke "

# Recarregue o terminal
source ~/.zshrc  # ou source ~/.bashrc
```

### 3. Variáveis de Ambiente para Testnet
```bash
# Definir variáveis para facilitar comandos
export TESTNET_RPC_URL="https://soroban-testnet.stellar.org"
export TESTNET_PASSPHRASE="Test SDF Network ; September 2015"
export TESTNET_NETWORK="testnet"
```

## 🔑 Configuração de Identidades na Testnet

### 1. Gerar ou Importar Identidades
```bash
# Gerar novas identidades para testnet
soroban keys generate testnet-bob --network testnet
soroban keys generate testnet-alice --network testnet

# OU importar identidades existentes (se você já tem)
# soroban keys import testnet-bob --secret-key <SEU_SECRET_KEY>
# soroban keys import testnet-alice --secret-key <SEU_SECRET_KEY>
```

### 2. Fundar Contas na Testnet
```bash
# Fundar bob na testnet
soroban keys fund testnet-bob --network testnet

# Fundar alice na testnet  
soroban keys fund testnet-alice --network testnet

# Verificar saldos
soroban keys ls --network testnet
```

## 🏗️ Compilação e Deploy na Testnet

### 1. Compilar o Contrato
```bash
# Navegar para o diretório do projeto
cd aula05

# Compilar o contrato
soroban contract build
```

### 2. Deploy do Contrato na Testnet
```bash
# Deploy usando bob como source
soroban contract deploy \
  --wasm target/wasm32v1-none/release/token.wasm \
  --source testnet-bob \
  --network testnet

# Salve o CONTRACT_ID retornado!
# Exemplo: CONTRACT_ID="CAPGL5BDXOPAND4PWDVY2KTAGJ6FUWPRNVKSVE2OLXPYYVQ7ZXRX2AAC"
```

### 3. Inicialização do Contrato
```bash
# Substitua <CONTRACT_ID> pelo ID real retornado no deploy
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source testnet-bob \
  --network testnet \
  -- \
  initialize \
  --admin $(soroban keys address testnet-bob) \
  --decimal 2 \
  --name RealDigital \
  --symbol DREX
```

## 🧪 Testes Completos na Testnet

### 1. Verificação de Metadados
```bash
# Verificar nome do token
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source testnet-bob \
  --network testnet \
  -- \
  name

# Verificar símbolo
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source testnet-bob \
  --network testnet \
  -- \
  symbol

# Verificar decimais
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source testnet-bob \
  --network testnet \
  -- \
  decimals

# Verificar admin
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source testnet-bob \
  --network testnet \
  -- \
  get_admin
```

### 2. Operações de Token

#### Consultar Saldos Iniciais
```bash
# Saldo de bob
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source testnet-bob \
  --network testnet \
  -- \
  balance \
  --id $(soroban keys address testnet-bob)

# Saldo de alice
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source testnet-alice \
  --network testnet \
  -- \
  balance \
  --id $(soroban keys address testnet-alice)
```

#### Mint de Tokens
```bash
# Mint 1000 DREX para alice
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source testnet-bob \
  --network testnet \
  -- \
  mint \
  --to $(soroban keys address testnet-alice) \
  --amount 1000

# Mint 500 DREX para bob
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source testnet-bob \
  --network testnet \
  -- \
  mint \
  --to $(soroban keys address testnet-bob) \
  --amount 500
```

#### Transferência Direta
```bash
# Alice transfere 200 DREX para bob
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source testnet-alice \
  --network testnet \
  -- \
  transfer \
  --from $(soroban keys address testnet-alice) \
  --to $(soroban keys address testnet-bob) \
  --amount 200
```

#### Aprovação e Transferência Autorizada
```bash
# Alice aprova bob para gastar 300 DREX
# Primeiro, precisamos obter o ledger atual + 100 para expiração
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source testnet-alice \
  --network testnet \
  -- \
  approve \
  --from $(soroban keys address testnet-alice) \
  --to $(soroban keys address testnet-bob) \
  --amount 300 \
  --expiration-ledger 1000000

# Bob transfere 150 DREX de alice usando aprovação
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source testnet-bob \
  --network testnet \
  -- \
  transfer_from \
  --from $(soroban keys address testnet-alice) \
  --to $(soroban keys address testnet-bob) \
  --amount 150
```

#### Operações de Burn
```bash
# Bob queima 50 DREX
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source testnet-bob \
  --network testnet \
  -- \
  burn \
  --from $(soroban keys address testnet-bob) \
  --amount 50

# Bob queima 25 DREX de alice usando aprovação
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source testnet-bob \
  --network testnet \
  -- \
  burn_from \
  --from $(soroban keys address testnet-alice) \
  --amount 25
```

#### Consulta de Allowance
```bash
# Verificar allowance de alice para bob
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source testnet-bob \
  --network testnet \
  -- \
  allowance \
  --from $(soroban keys address testnet-alice) \
  --spender $(soroban keys address testnet-bob)
```

### 3. Operações Administrativas

#### Mudança de Admin
```bash
# Bob transfere admin para alice
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source testnet-bob \
  --network testnet \
  -- \
  set_admin \
  --new-admin $(soroban keys address testnet-alice)

# Verificar novo admin
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source testnet-alice \
  --network testnet \
  -- \
  get_admin
```

## 🔍 Verificação Final dos Saldos

```bash
# Saldo final de bob
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source testnet-bob \
  --network testnet \
  -- \
  balance \
  --id $(soroban keys address testnet-bob)

# Saldo final de alice
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source testnet-alice \
  --network testnet \
  -- \
  balance \
  --id $(soroban keys address testnet-alice)
```

## 🎯 Comandos com Aliases (Versão Simplificada)

### Usando Aliases Configurados:
```bash
# Deploy
scd --wasm target/wasm32v1-none/release/token.wasm --source testnet-bob --network testnet

# Consultar saldo
sci --id <CONTRACT_ID> --source testnet-bob --network testnet -- balance --id $(ska testnet-bob)

# Mint tokens
sci --id <CONTRACT_ID> --source testnet-bob --network testnet -- mint --to $(ska testnet-alice) --amount 1000

# Transferência
sci --id <CONTRACT_ID> --source testnet-alice --network testnet -- transfer --from $(ska testnet-alice) --to $(ska testnet-bob) --amount 200
```

## 📊 Script de Teste Automatizado

Crie um arquivo `testnet_test.sh`:

```bash
#!/bin/bash

# Configurar variáveis
CONTRACT_ID="<SEU_CONTRACT_ID_AQUI>"
BOB_ADDRESS=$(soroban keys address testnet-bob)
ALICE_ADDRESS=$(soroban keys address testnet-alice)

echo "🚀 Iniciando testes na testnet..."
echo "Contract ID: $CONTRACT_ID"
echo "Bob Address: $BOB_ADDRESS"
echo "Alice Address: $ALICE_ADDRESS"

# Teste 1: Verificar metadados
echo "📋 Teste 1: Verificando metadados..."
soroban contract invoke --id $CONTRACT_ID --source testnet-bob --network testnet -- name
soroban contract invoke --id $CONTRACT_ID --source testnet-bob --network testnet -- symbol
soroban contract invoke --id $CONTRACT_ID --source testnet-bob --network testnet -- decimals

# Teste 2: Mint tokens
echo "🪙 Teste 2: Mintando tokens..."
soroban contract invoke --id $CONTRACT_ID --source testnet-bob --network testnet -- mint --to $ALICE_ADDRESS --amount 1000

# Teste 3: Transferência
echo "💸 Teste 3: Transferindo tokens..."
soroban contract invoke --id $CONTRACT_ID --source testnet-alice --network testnet -- transfer --from $ALICE_ADDRESS --to $BOB_ADDRESS --amount 200

# Teste 4: Verificar saldos
echo "💰 Teste 4: Verificando saldos..."
soroban contract invoke --id $CONTRACT_ID --source testnet-bob --network testnet -- balance --id $BOB_ADDRESS
soroban contract invoke --id $CONTRACT_ID --source testnet-alice --network testnet -- balance --id $ALICE_ADDRESS

echo "✅ Testes concluídos!"
```

## ⚠️ Troubleshooting na Testnet

### Problemas Comuns:

1. **Erro de Rede:**
```bash
# Verificar conectividade
curl -s https://soroban-testnet.stellar.org/ | head -5

# Verificar configuração da rede
soroban config network ls
```

2. **Erro de Saldo Insuficiente:**
```bash
# Fundar novamente se necessário
soroban keys fund testnet-bob --network testnet
soroban keys fund testnet-alice --network testnet
```

3. **Erro de Expiração:**
```bash
# Para approve, use um ledger futuro (atual + 1000)
# Exemplo: se o ledger atual é 1000000, use 1001000
```

4. **Erro de Autenticação:**
```bash
# Verificar se a identidade está correta
soroban keys ls --network testnet

# Verificar se a conta tem saldo
soroban keys fund <IDENTIDADE> --network testnet
```

## 📝 Checklist de Testes

- [ ] Configuração da testnet
- [ ] Geração/funding de identidades
- [ ] Compilação do contrato
- [ ] Deploy na testnet
- [ ] Inicialização do contrato
- [ ] Verificação de metadados
- [ ] Mint de tokens
- [ ] Transferência direta
- [ ] Aprovação de gastos
- [ ] Transferência autorizada
- [ ] Operações de burn
- [ ] Mudança de admin
- [ ] Verificação final de saldos

## 🎯 Resultados Esperados

Após executar todos os testes, você deve ter:

1. **Contrato funcionando** na testnet
2. **Metadados corretos** (RealDigital, DREX, 2 decimais)
3. **Operações de token** executadas com sucesso
4. **Eventos emitidos** para cada operação
5. **Saldos finais** consistentes com as operações

---

## 🔗 Links Úteis

- [Soroban Testnet Explorer](https://soroban.stellar.org/)
- [Stellar Testnet](https://laboratory.stellar.org/)
- [Soroban Documentation](https://soroban.stellar.org/docs)
- [Stellar Testnet Faucet](https://laboratory.stellar.org/#account-creator?network=testnet) 