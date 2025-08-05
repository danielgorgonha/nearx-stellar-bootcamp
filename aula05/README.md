# Soroban 102

## make alias

```bash
# ~/.zshrc
# ~/.bashrc

alias ska="soroban keys address "
alias skl="soroban keys ls "
alias scd="soroban contract deploy "
alias sci="soroban contract invoke "
```

## Deploy contract

```bash
scd \
  --wasm target/wasm32-unknown-unknown/release/token.wasm \
  --source bob \
  --network local
```

## Get balance

```bash
sci \
    --id CCIFKHKLPDAIITTUNSNLBKE4EIWLSR4JY2YTIJXACJWXPBEMUKTU6WTP \
    --source bob \
    --network local \
    -- \
    balance \
    --id $(ska bob)
```

## Initialization of contract

```bash
sci \
    --id CCIFKHKLPDAIITTUNSNLBKE4EIWLSR4JY2YTIJXACJWXPBEMUKTU6WTP \
    --source bob \
    --network local \
    -- \
    initialize --admin $(ska bob) --decimal 2 --name RealDigital --symbol DREX
```

## Get admin of contract

```bash
sci \
    --id CCIFKHKLPDAIITTUNSNLBKE4EIWLSR4JY2YTIJXACJWXPBEMUKTU6WTP \
    --source bob \
    --network local \
    -- \
    get_admin
```

## Mint _DREX_ for `alice`

```bash
sci \
    --id CCIFKHKLPDAIITTUNSNLBKE4EIWLSR4JY2YTIJXACJWXPBEMUKTU6WTP \
    --source bob \
    --network local \
    -- \
    mint --to $(ska alice) --amount 100
```

## Transfer from `alice` to `bob`

```bash
sci \
    --id CCIFKHKLPDAIITTUNSNLBKE4EIWLSR4JY2YTIJXACJWXPBEMUKTU6WTP \
    --source alice \
    --network local \
    -- \
    transfer \
    --from $(ska alice) \
    --to $(ska bob) \
    --amount 100
```

## Approve from `alice` to `bob`

```bash
sci \
    --id CCIFKHKLPDAIITTUNSNLBKE4EIWLSR4JY2YTIJXACJWXPBEMUKTU6WTP \
    --source alice \
    --network local \
    -- \
    approve \
    --from $(ska alice) \
    --to $(ska bob) \
    --amount 100
```

## TransferFrom `bob` spend `alice`'s money

```bash
sci \
    --id CCIFKHKLPDAIITTUNSNLBKE4EIWLSR4JY2YTIJXACJWXPBEMUKTU6WTP \
    --source bob \
    --network local \
    -- \
    trasfer_from \
    --from $(ska alice) \
    --to $(ska bob) \
    --amount 100
```


## NOVOS COMANDOS ATUALIZADOS (Versão Soroban CLI Atual)

### 1. Configurar Aliases para Produtividade

```bash
# Adicione ao seu ~/.zshrc ou ~/.bashrc
alias ska="soroban keys address "
alias skl="soroban keys ls "
alias scd="soroban contract deploy "
alias sci="soroban contract invoke "

# Recarregue o terminal
source ~/.zshrc  # ou source ~/.bashrc
```

### 2. Configurar Rede e Identidades

```bash
# Gerar identidades (se necessário)
soroban keys generate bob --rpc-url "http://localhost:8000/soroban/rpc" --network-passphrase "Standalone Network ; February 2017"
soroban keys generate alice --rpc-url "http://localhost:8000/soroban/rpc" --network-passphrase "Standalone Network ; February 2017"

# Fundar contas
soroban keys fund bob --rpc-url "http://localhost:8000/soroban/rpc" --network-passphrase "Standalone Network ; February 2017"
soroban keys fund alice --rpc-url "http://localhost:8000/soroban/rpc" --network-passphrase "Standalone Network ; February 2017"
```

### 3. Compilar e Deploy do Contrato Token

```bash
# Compilar o contrato
soroban contract build

# Deploy do contrato token
soroban contract deploy \
  --wasm target/wasm32v1-none/release/token.wasm \
  --source bob \
  --rpc-url "http://localhost:8000/soroban/rpc" \
  --network-passphrase "Standalone Network ; February 2017"
```

### 4. Inicialização do Contrato Token

```bash
# Inicializar o contrato com parâmetros
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source bob \
  --rpc-url "http://localhost:8000/soroban/rpc" \
  --network-passphrase "Standalone Network ; February 2017" \
  -- \
  initialize \
  --admin $(soroban keys address bob) \
  --decimal 2 \
  --name RealDigital \
  --symbol DREX
```

### 5. Operações de Token

#### Consultar Saldo
```bash
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source bob \
  --rpc-url "http://localhost:8000/soroban/rpc" \
  --network-passphrase "Standalone Network ; February 2017" \
  -- \
  balance \
  --id $(soroban keys address bob)
```

#### Consultar Admin
```bash
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source bob \
  --rpc-url "http://localhost:8000/soroban/rpc" \
  --network-passphrase "Standalone Network ; February 2017" \
  -- \
  get_admin
```

#### Mint de Tokens
```bash
# Mint DREX para alice
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source bob \
  --rpc-url "http://localhost:8000/soroban/rpc" \
  --network-passphrase "Standalone Network ; February 2017" \
  -- \
  mint \
  --to $(soroban keys address alice) \
  --amount 100
```

#### Transferência Direta
```bash
# Transferir de alice para bob
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source alice \
  --rpc-url "http://localhost:8000/soroban/rpc" \
  --network-passphrase "Standalone Network ; February 2017" \
  -- \
  transfer \
  --from $(soroban keys address alice) \
  --to $(soroban keys address bob) \
  --amount 100
```

#### Aprovação de Gastos
```bash
# Alice aprova bob para gastar seus tokens
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source alice \
  --rpc-url "http://localhost:8000/soroban/rpc" \
  --network-passphrase "Standalone Network ; February 2017" \
  -- \
  approve \
  --from $(soroban keys address alice) \
  --to $(soroban keys address bob) \
  --amount 100
```

#### Transferência Autorizada
```bash
# Bob transfere tokens de alice usando aprovação
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source bob \
  --rpc-url "http://localhost:8000/soroban/rpc" \
  --network-passphrase "Standalone Network ; February 2017" \
  -- \
  transfer_from \
  --from $(soroban keys address alice) \
  --to $(soroban keys address bob) \
  --amount 100
```

### 6. Comandos com Aliases (Versão Simplificada)

#### Usando Aliases Configurados:
```bash
# Deploy
scd --wasm target/wasm32v1-none/release/token.wasm --source bob --rpc-url "http://localhost:8000/soroban/rpc" --network-passphrase "Standalone Network ; February 2017"

# Consultar saldo
sci --id <CONTRACT_ID> --source bob --rpc-url "http://localhost:8000/soroban/rpc" --network-passphrase "Standalone Network ; February 2017" -- balance --id $(ska bob)

# Mint tokens
sci --id <CONTRACT_ID> --source bob --rpc-url "http://localhost:8000/soroban/rpc" --network-passphrase "Standalone Network ; February 2017" -- mint --to $(ska alice) --amount 100
```

### 7. Variáveis de Ambiente (Opcional)

Para facilitar ainda mais, você pode definir variáveis de ambiente:

```bash
export STELLAR_RPC_URL="http://localhost:8000/soroban/rpc"
export STELLAR_NETWORK_PASSPHRASE="Standalone Network ; February 2017"

# Então usar comandos mais simples:
soroban contract deploy --wasm target/wasm32v1-none/release/token.wasm --source bob
soroban contract invoke --id <CONTRACT_ID> --source bob -- balance --id $(soroban keys address bob)
```

### 8. Troubleshooting

#### Se houver erro de rede:
```bash
# Verificar se o node está rodando
curl -s http://localhost:8000/ | head -5

# Verificar se as identidades existem
soroban keys ls
```

#### Se houver erro de compilação:
```bash
# Verificar se o target WASM está instalado
rustup target list | grep wasm32v1-none

# Instalar se necessário
rustup target add wasm32v1-none
```

---

## 📝 **Notas Importantes:**

1. **Substitua `<CONTRACT_ID>`** pelo ID real do contrato após o deploy
2. **Use as identidades corretas** (bob, alice) conforme necessário
3. **Verifique se o node local está rodando** antes de executar comandos
4. **Os aliases facilitam** mas não são obrigatórios
5. **Sempre use os parâmetros completos** (rpc-url, network-passphrase) para evitar erros

## 🧪 Resultados dos Testes Realizados

### ✅ Testes Executados com Sucesso

**Contrato Deployado:** `CAPGL5BDXOPAND4PWDVY2KTAGJ6FUWPRNVKSVE2OLXPYYVQ7ZXRX2AAC`

#### 1. **Inicialização do Contrato**
```bash
# Inicialização com parâmetros
soroban contract invoke --id CAPGL5BDXOPAND4PWDVY2KTAGJ6FUWPRNVKSVE2OLXPYYVQ7ZXRX2AAC --source bob --rpc-url "http://localhost:8000/soroban/rpc" --network-passphrase "Standalone Network ; February 2017" -- initialize --admin $(soroban keys address bob) --decimal 2 --name RealDigital --symbol DREX
```
**Resultado:** ✅ Contrato inicializado com sucesso

#### 2. **Verificação de Metadados**
- **Nome:** `RealDigital` ✅
- **Símbolo:** `DREX` ✅  
- **Decimais:** `2` ✅
- **Admin:** `GDHQKNIGW3ZGWNHPC26OGTUFHDWBQE2S6AVOAR2UE7HYDV2KGN52EV2X` ✅

#### 3. **Operação de Mint**
```bash
# Mint de 100 tokens para alice
soroban contract invoke --id CAPGL5BDXOPAND4PWDVY2KTAGJ6FUWPRNVKSVE2OLXPYYVQ7ZXRX2AAC --source bob --rpc-url "http://localhost:8000/soroban/rpc" --network-passphrase "Standalone Network ; February 2017" -- mint --to $(soroban keys address alice) --amount 100
```
**Resultado:** ✅ 100 tokens mintados para alice
**Evento:** `mint` emitido com sucesso

#### 4. **Operação de Transfer**
```bash
# Transferência de 50 tokens de alice para bob
soroban contract invoke --id CAPGL5BDXOPAND4PWDVY2KTAGJ6FUWPRNVKSVE2OLXPYYVQ7ZXRX2AAC --source alice --rpc-url "http://localhost:8000/soroban/rpc" --network-passphrase "Standalone Network ; February 2017" -- transfer --from $(soroban keys address alice) --to $(soroban keys address bob) --amount 50
```
**Resultado:** ✅ Transferência executada
**Saldo Final:**
- Alice: 50 tokens
- Bob: 50 tokens
**Evento:** `transfer` emitido com sucesso

#### 5. **Operação de Burn**
```bash
# Burn de 10 tokens de bob
soroban contract invoke --id CAPGL5BDXOPAND4PWDVY2KTAGJ6FUWPRNVKSVE2OLXPYYVQ7ZXRX2AAC --source bob --rpc-url "http://localhost:8000/soroban/rpc" --network-passphrase "Standalone Network ; February 2017" -- burn --from $(soroban keys address bob) --amount 10
```
**Resultado:** ✅ 10 tokens queimados
**Saldo Final de Bob:** 40 tokens
**Evento:** `burn` emitido com sucesso

### 📊 Resumo dos Saldos Finais
- **Alice:** 50 DREX tokens
- **Bob:** 40 DREX tokens
- **Total em Circulação:** 90 DREX tokens (100 mintados - 10 queimados)

### ⚠️ Funcionalidades Pendentes de Teste
- **Approve/TransferFrom:** Encontrou problemas com parâmetros de expiração
- **Burn From:** Não testado ainda
- **Set Admin:** Não testado ainda

### 🎯 Status da Aula 5: ✅ FUNCIONALIDADE BÁSICA TESTADA

O contrato token ERC-20 está funcionando corretamente para as operações principais:
- ✅ Deploy e Inicialização
- ✅ Mint de tokens
- ✅ Transferência direta
- ✅ Burn de tokens
- ✅ Consulta de metadados (nome, símbolo, decimais)
- ✅ Consulta de saldos
- ✅ Emissão de eventos

**Próximos passos:** Implementar e testar funcionalidades avançadas como approve/transferFrom.