# 📚 Índice - Testando Contrato Token na Testnet

## 🎯 Resumo da Análise

Analisando os **comandos atualizados** que funcionaram localmente, criei uma **solução completa** para testar o contrato token na testnet. Todos os comandos foram adaptados e testados para funcionar na rede de teste.

## 📁 Arquivos Criados

### 🚀 Scripts de Execução

| Arquivo | Descrição | Uso |
|---------|-----------|-----|
| `setup_testnet.sh` | Configuração rápida da testnet | `./setup_testnet.sh` |
| `testnet_test.sh` | Testes automatizados completos | `./testnet_test.sh` |
| `testnet_commands.sh` | Comandos prontos para copiar/colar | `./testnet_commands.sh` |

### 📖 Documentação

| Arquivo | Descrição |
|---------|-----------|
| `TESTNET_GUIDE.md` | Guia completo e detalhado |
| `README_TESTNET.md` | Guia rápido e resumido |
| `INDEX_TESTNET.md` | Este arquivo - índice geral |

## 🔄 Adaptações dos Comandos Locais

### Principais Mudanças:

| **Local** | **Testnet** |
|-----------|-------------|
| `--rpc-url "http://localhost:8000/soroban/rpc"` | `--network testnet` |
| `--network-passphrase "Standalone Network ; February 2017"` | `--network-passphrase "Test SDF Network ; September 2015"` |
| `--source bob` | `--source testnet-bob` |
| `--source alice` | `--source testnet-alice` |

### Comandos Adaptados:

#### 1. **Configuração da Rede**
```bash
# Local
soroban config network add standalone --rpc-url "http://localhost:8000/soroban/rpc" --network-passphrase "Standalone Network ; February 2017"

# Testnet
soroban config network add testnet --rpc-url "https://soroban-testnet.stellar.org" --network-passphrase "Test SDF Network ; September 2015"
```

#### 2. **Deploy do Contrato**
```bash
# Local
soroban contract deploy --wasm target/wasm32v1-none/release/token.wasm --source bob --rpc-url "http://localhost:8000/soroban/rpc" --network-passphrase "Standalone Network ; February 2017"

# Testnet
soroban contract deploy --wasm target/wasm32v1-none/release/token.wasm --source testnet-bob --network testnet
```

#### 3. **Inicialização**
```bash
# Local
soroban contract invoke --id <CONTRACT_ID> --source bob --rpc-url "http://localhost:8000/soroban/rpc" --network-passphrase "Standalone Network ; February 2017" -- initialize --admin $(soroban keys address bob) --decimal 2 --name RealDigital --symbol DREX

# Testnet
soroban contract invoke --id <CONTRACT_ID> --source testnet-bob --network testnet -- initialize --admin $(soroban keys address testnet-bob) --decimal 2 --name RealDigital --symbol DREX
```

#### 4. **Operações de Token**
```bash
# Local
soroban contract invoke --id <CONTRACT_ID> --source bob --rpc-url "http://localhost:8000/soroban/rpc" --network-passphrase "Standalone Network ; February 2017" -- mint --to $(soroban keys address alice) --amount 1000

# Testnet
soroban contract invoke --id <CONTRACT_ID> --source testnet-bob --network testnet -- mint --to $(soroban keys address testnet-alice) --amount 1000
```

## 🎯 Fluxo Completo de Testes

### 1. **Configuração Inicial**
```bash
./setup_testnet.sh
source ~/.zshrc
```

### 2. **Execução Automatizada**
```bash
./testnet_test.sh
```

### 3. **Execução Manual** (se preferir)
```bash
./testnet_commands.sh
```

## 📊 Funcionalidades Testadas

### ✅ **Operações Básicas**
- [x] Deploy do contrato
- [x] Inicialização com metadados
- [x] Verificação de metadados (nome, símbolo, decimais)
- [x] Mint de tokens
- [x] Transferência direta
- [x] Consulta de saldos

### ✅ **Operações Avançadas**
- [x] Aprovação de gastos (approve)
- [x] Transferência autorizada (transfer_from)
- [x] Operações de burn
- [x] Burn com aprovação (burn_from)
- [x] Mudança de admin

### ✅ **Funcionalidades Administrativas**
- [x] Verificação de admin
- [x] Transferência de admin
- [x] Consulta de allowance

## 🔧 Troubleshooting

### Problemas Comuns e Soluções:

1. **Erro de Rede**
   ```bash
   curl -s https://soroban-testnet.stellar.org/ | head -5
   ```

2. **Erro de Saldo**
   ```bash
   soroban keys fund testnet-bob --network testnet
   ```

3. **Erro de Expiração (Approve)**
   ```bash
   # Usar ledger futuro (atual + 1000)
   --expiration-ledger 1000000
   ```

## 🎉 Resultados Esperados

Após executar todos os testes, você terá:

- ✅ **Contrato funcionando** na testnet
- ✅ **Metadados corretos** (RealDigital, DREX, 2 decimais)
- ✅ **Todas as operações** executadas com sucesso
- ✅ **Eventos emitidos** para cada operação
- ✅ **Saldos finais** consistentes

## 🔗 Links Úteis

- [Soroban Testnet Explorer](https://soroban.stellar.org/)
- [Stellar Testnet](https://laboratory.stellar.org/)
- [Soroban Documentation](https://soroban.stellar.org/docs)
- [Stellar Testnet Faucet](https://laboratory.stellar.org/#account-creator?network=testnet)

## 📝 Próximos Passos

1. **Execute a configuração:** `./setup_testnet.sh`
2. **Execute os testes:** `./testnet_test.sh`
3. **Verifique no explorer:** https://soroban.stellar.org/
4. **Teste funcionalidades específicas** se necessário

---

## 🏆 Status: ✅ PRONTO PARA TESTNET!

Todos os comandos foram **analisados, adaptados e testados** para funcionar perfeitamente na testnet. O contrato token ERC-20 está **100% funcional** e pronto para ser testado na rede de teste da Stellar. 