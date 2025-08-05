#!/bin/bash

# 🚀 Comandos Prontos para Testnet
# Copie e cole estes comandos no terminal

echo "🚀 Configurando testnet..."

# 1. Configurar rede testnet
soroban config network add testnet \
  --rpc-url "https://soroban-testnet.stellar.org" \
  --network-passphrase "Test SDF Network ; September 2015"

soroban config network set testnet

echo "✅ Testnet configurada"

# 2. Gerar identidades
echo "🔑 Gerando identidades..."
soroban keys generate testnet-bob --network testnet
soroban keys generate testnet-alice --network testnet

# 3. Fundar contas
echo "💰 Fundando contas..."
soroban keys fund testnet-bob --network testnet
soroban keys fund testnet-alice --network testnet

# 4. Compilar contrato
echo "🏗️ Compilando contrato..."
soroban contract build

# 5. Deploy do contrato
echo "🚀 Fazendo deploy..."
CONTRACT_ID=$(soroban contract deploy \
  --wasm target/wasm32v1-none/release/token.wasm \
  --source testnet-bob \
  --network testnet)

echo "Contract ID: $CONTRACT_ID"

# 6. Inicializar contrato
echo "⚙️ Inicializando contrato..."
soroban contract invoke \
  --id $CONTRACT_ID \
  --source testnet-bob \
  --network testnet \
  -- \
  initialize \
  --admin $(soroban keys address testnet-bob) \
  --decimal 2 \
  --name RealDigital \
  --symbol DREX

echo "✅ Contrato inicializado"

# 7. Verificar metadados
echo "📋 Verificando metadados..."
echo "Nome: $(soroban contract invoke --id $CONTRACT_ID --source testnet-bob --network testnet -- name)"
echo "Símbolo: $(soroban contract invoke --id $CONTRACT_ID --source testnet-bob --network testnet -- symbol)"
echo "Decimais: $(soroban contract invoke --id $CONTRACT_ID --source testnet-bob --network testnet -- decimals)"

# 8. Mint tokens
echo "🪙 Mintando tokens..."
soroban contract invoke \
  --id $CONTRACT_ID \
  --source testnet-bob \
  --network testnet \
  -- \
  mint \
  --to $(soroban keys address testnet-alice) \
  --amount 1000

soroban contract invoke \
  --id $CONTRACT_ID \
  --source testnet-bob \
  --network testnet \
  -- \
  mint \
  --to $(soroban keys address testnet-bob) \
  --amount 500

# 9. Verificar saldos
echo "💰 Verificando saldos..."
BOB_BALANCE=$(soroban contract invoke --id $CONTRACT_ID --source testnet-bob --network testnet -- balance --id $(soroban keys address testnet-bob))
ALICE_BALANCE=$(soroban contract invoke --id $CONTRACT_ID --source testnet-alice --network testnet -- balance --id $(soroban keys address testnet-alice))

echo "Saldo de Bob: $BOB_BALANCE DREX"
echo "Saldo de Alice: $ALICE_BALANCE DREX"

# 10. Transferência
echo "💸 Fazendo transferência..."
soroban contract invoke \
  --id $CONTRACT_ID \
  --source testnet-alice \
  --network testnet \
  -- \
  transfer \
  --from $(soroban keys address testnet-alice) \
  --to $(soroban keys address testnet-bob) \
  --amount 200

# 11. Approve e TransferFrom
echo "🔐 Testando approve e transfer_from..."
soroban contract invoke \
  --id $CONTRACT_ID \
  --source testnet-alice \
  --network testnet \
  -- \
  approve \
  --from $(soroban keys address testnet-alice) \
  --to $(soroban keys address testnet-bob) \
  --amount 300 \
  --expiration-ledger 1000000

soroban contract invoke \
  --id $CONTRACT_ID \
  --source testnet-bob \
  --network testnet \
  -- \
  transfer_from \
  --from $(soroban keys address testnet-alice) \
  --to $(soroban keys address testnet-bob) \
  --amount 150

# 12. Operações de burn
echo "🔥 Testando operações de burn..."
soroban contract invoke \
  --id $CONTRACT_ID \
  --source testnet-bob \
  --network testnet \
  -- \
  burn \
  --from $(soroban keys address testnet-bob) \
  --amount 50

soroban contract invoke \
  --id $CONTRACT_ID \
  --source testnet-bob \
  --network testnet \
  -- \
  burn_from \
  --from $(soroban keys address testnet-alice) \
  --amount 25

# 13. Verificar saldos finais
echo "📊 Saldos finais..."
FINAL_BOB_BALANCE=$(soroban contract invoke --id $CONTRACT_ID --source testnet-bob --network testnet -- balance --id $(soroban keys address testnet-bob))
FINAL_ALICE_BALANCE=$(soroban contract invoke --id $CONTRACT_ID --source testnet-alice --network testnet -- balance --id $(soroban keys address testnet-alice))

echo "Saldo final de Bob: $FINAL_BOB_BALANCE DREX"
echo "Saldo final de Alice: $FINAL_ALICE_BALANCE DREX"

# 14. Resumo
echo ""
echo "🎉 Testes concluídos!"
echo "Contract ID: $CONTRACT_ID"
echo "Verificar no explorer: https://soroban.stellar.org/"
echo ""
echo "📋 Resumo das operações:"
echo "  - Mint: 1000 DREX para Alice, 500 DREX para Bob"
echo "  - Transfer: 200 DREX de Alice para Bob"
echo "  - Approve: Alice aprovou Bob para 300 DREX"
echo "  - TransferFrom: Bob transferiu 150 DREX de Alice"
echo "  - Burn: 50 DREX de Bob, 25 DREX de Alice"
echo ""
echo "💰 Saldos finais:"
echo "  - Bob: $FINAL_BOB_BALANCE DREX"
echo "  - Alice: $FINAL_ALICE_BALANCE DREX" 