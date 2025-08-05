# 🚀 Testando Contrato Token na Testnet - Guia Rápido

## 📋 Resumo dos Comandos Atualizados

Analisando os comandos que funcionaram localmente, aqui está a adaptação completa para **testnet**:

### 🔧 Principais Diferenças para Testnet

| Local | Testnet |
|-------|---------|
| `--rpc-url "http://localhost:8000/soroban/rpc"` | `--network testnet` |
| `--network-passphrase "Standalone Network ; February 2017"` | `--network-passphrase "Test SDF Network ; September 2015"` |
| `--source bob` | `--source testnet-bob` |
| `--source alice` | `--source testnet-alice` |

## 🚀 Configuração Rápida

### 1. Configurar Ambiente
```bash
# Executar script de configuração
./setup_testnet.sh

# Recarregar terminal
source ~/.zshrc
```

### 2. Executar Testes Automatizados
```bash
# Executar todos os testes
./testnet_test.sh
```

## 📝 Comandos Manuais (Passo a Passo)

### 1. Configuração da Testnet
```bash
# Configurar rede testnet
soroban config network add testnet \
  --rpc-url "https://soroban-testnet.stellar.org" \
  --network-passphrase "Test SDF Network ; September 2015"

# Definir como padrão
soroban config network set testnet
```

### 2. Criar Identidades
```bash
# Gerar identidades para testnet
soroban keys generate testnet-bob --network testnet
soroban keys generate testnet-alice --network testnet

# Fundar contas
soroban keys fund testnet-bob --network testnet
soroban keys fund testnet-alice --network testnet
```

### 3. Compilar e Deploy
```bash
# Compilar
soroban contract build

# Deploy
soroban contract deploy \
  --wasm target/wasm32v1-none/release/token.wasm \
  --source testnet-bob \
  --network testnet
```

### 4. Inicializar Contrato
```bash
# Substitua <CONTRACT_ID> pelo ID retornado no deploy
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

## 🧪 Testes Completos

### Verificar Metadados
```bash
# Nome
soroban contract invoke --id <CONTRACT_ID> --source testnet-bob --network testnet -- name

# Símbolo  
soroban contract invoke --id <CONTRACT_ID> --source testnet-bob --network testnet -- symbol

# Decimais
soroban contract invoke --id <CONTRACT_ID> --source testnet-bob --network testnet -- decimals

# Admin
soroban contract invoke --id <CONTRACT_ID> --source testnet-bob --network testnet -- get_admin
```

### Operações de Token
```bash
# Mint para alice
soroban contract invoke --id <CONTRACT_ID> --source testnet-bob --network testnet -- mint --to $(soroban keys address testnet-alice) --amount 1000

# Mint para bob
soroban contract invoke --id <CONTRACT_ID> --source testnet-bob --network testnet -- mint --to $(soroban keys address testnet-bob) --amount 500

# Transferência
soroban contract invoke --id <CONTRACT_ID> --source testnet-alice --network testnet -- transfer --from $(soroban keys address testnet-alice) --to $(soroban keys address testnet-bob) --amount 200

# Consultar saldos
soroban contract invoke --id <CONTRACT_ID> --source testnet-bob --network testnet -- balance --id $(soroban keys address testnet-bob)
soroban contract invoke --id <CONTRACT_ID> --source testnet-alice --network testnet -- balance --id $(soroban keys address testnet-alice)
```

### Approve e TransferFrom
```bash
# Alice aprova bob
soroban contract invoke --id <CONTRACT_ID> --source testnet-alice --network testnet -- approve --from $(soroban keys address testnet-alice) --to $(soroban keys address testnet-bob) --amount 300 --expiration-ledger 1000000

# Bob transfere de alice
soroban contract invoke --id <CONTRACT_ID> --source testnet-bob --network testnet -- transfer_from --from $(soroban keys address testnet-alice) --to $(soroban keys address testnet-bob) --amount 150

# Verificar allowance
soroban contract invoke --id <CONTRACT_ID> --source testnet-bob --network testnet -- allowance --from $(soroban keys address testnet-alice) --spender $(soroban keys address testnet-bob)
```

### Operações de Burn
```bash
# Burn direto
soroban contract invoke --id <CONTRACT_ID> --source testnet-bob --network testnet -- burn --from $(soroban keys address testnet-bob) --amount 50

# Burn com aprovação
soroban contract invoke --id <CONTRACT_ID> --source testnet-bob --network testnet -- burn_from --from $(soroban keys address testnet-alice) --amount 25
```

## 🎯 Comandos com Aliases

Após configurar os aliases:

```bash
# Deploy
scd --wasm target/wasm32v1-none/release/token.wasm --source testnet-bob --network testnet

# Consultar saldo
sci --id <CONTRACT_ID> --source testnet-bob --network testnet -- balance --id $(ska testnet-bob)

# Mint
sci --id <CONTRACT_ID> --source testnet-bob --network testnet -- mint --to $(ska testnet-alice) --amount 1000
```

## ⚠️ Troubleshooting

### Erros Comuns:

1. **Erro de Rede:**
```bash
# Verificar conectividade
curl -s https://soroban-testnet.stellar.org/ | head -5
```

2. **Erro de Saldo:**
```bash
# Fundar novamente
soroban keys fund testnet-bob --network testnet
```

3. **Erro de Expiração (Approve):**
```bash
# Usar ledger futuro (atual + 1000)
# Exemplo: se atual é 1000000, usar 1001000
```

## 📊 Resultados Esperados

Após todos os testes:

- ✅ **Contrato funcionando** na testnet
- ✅ **Metadados corretos** (RealDigital, DREX, 2 decimais)
- ✅ **Operações de token** executadas
- ✅ **Approve/TransferFrom** funcionando
- ✅ **Operações de burn** executadas
- ✅ **Eventos emitidos** para cada operação

## 🔗 Links Úteis

- [Soroban Testnet Explorer](https://soroban.stellar.org/)
- [Stellar Testnet](https://laboratory.stellar.org/)
- [Soroban Documentation](https://soroban.stellar.org/docs)

---

## 🎉 Próximos Passos

1. Execute `./setup_testnet.sh` para configurar
2. Execute `./testnet_test.sh` para testar tudo
3. Verifique os resultados no explorer
4. Teste funcionalidades específicas manualmente se necessário

**Status:** ✅ Pronto para testar na testnet! 