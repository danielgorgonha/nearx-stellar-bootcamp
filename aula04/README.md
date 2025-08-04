# Soroban 101 - Smart Contracts Avançados

## 🎯 **Objetivo da Aula 4**

Esta aula foca no desenvolvimento prático de smart contracts Soroban usando Rust, explorando conceitos fundamentais como estado persistente, armazenamento, estruturas de dados complexas e operações CRUD.

## 📚 **Conceitos Aprendidos**

### **1. Estado Persistente e Storage**
- **Instance Storage:** Armazenamento de dados que vivem com o contrato
- **Symbols:** Identificadores para chaves de armazenamento
- **TTL Management:** Controle de expiração de dados
- **Persistência:** Manutenção de estado entre transações

### **2. Estruturas de Dados**
- **Structs:** Definição de tipos customizados (`Task`)
- **Enums:** Para tipos com variantes (`Error`)
- **Maps:** Para armazenamento chave-valor
- **Vec:** Para listas dinâmicas
- **Option Types:** Para valores que podem não existir

### **3. Error Handling**
- **Custom Errors:** Definição de tipos de erro específicos
- **Result Types:** Tratamento seguro de operações que podem falhar
- **Traits:** Definição de interfaces para contratos

### **4. Operações CRUD**
- **Create:** Adicionar novos registros
- **Read:** Consultar dados existentes
- **Update:** Modificar registros
- **Delete:** Remover registros

## 🏗️ **Contratos Implementados**

### **1. Flipper - Gerenciamento de Estado Booleano**

**Conceito:** Demonstra como gerenciar estado booleano em smart contracts.

**Funcionalidades:**
- `flip()`: Inverte o estado atual (true ↔ false)
- `get_state()`: Retorna o estado atual

**Aprendizados:**
- Uso básico de storage instance
- Operações booleanas
- Persistência de estado simples

**Resultado dos Testes:**
```
Estado inicial: false
Após flip(): true
✅ Funcionando perfeitamente
```

### **2. Increment - Contador com TTL**

**Conceito:** Demonstra contadores e gerenciamento de ciclo de vida.

**Funcionalidades:**
- `increment()`: Incrementa o contador e estende TTL
- `get_counter()`: Retorna o valor atual

**Aprendizados:**
- Contadores numéricos
- TTL (Time To Live) management
- Logging durante execução
- Extensão automática de vida útil

**Resultado dos Testes:**
```
Contador inicial: 0
Após increment(): 1
✅ Funcionando perfeitamente
```

### **3. Task Manager - CRUD Completo**

**Conceito:** Aplicação completa de gerenciamento de tarefas.

**Funcionalidades:**
- `add_task()`: Cria nova tarefa
- `get_task()`: Recupera tarefa específica
- `get_all_tasks()`: Lista todas as tarefas
- `complete_task()`: Marca como concluída
- `delete_task()`: Remove tarefa

**Aprendizados:**
- Estruturas de dados complexas
- Operações CRUD completas
- Error handling avançado
- Maps e collections
- Validação de dados

**Resultado dos Testes:**
```
Tarefa adicionada: "Limpar_o_carro" (ID: 1)
Status inicial: done: false
Após complete_task(): done: true
✅ Funcionando perfeitamente
```

## 🔧 **Desafios Encontrados e Soluções**

### **1. Atualização da CLI Soroban**
**Problema:** Comandos antigos não funcionavam na versão atual
**Solução:** Atualizamos a documentação com comandos corretos da nova CLI

### **2. Friendbot Local**
**Problema:** Friendbot não estava habilitado no node local
**Solução:** Atualizamos o docker-compose.yaml (removemos flag inexistente)

### **3. Target WASM**
**Problema:** Target `wasm32v1-none` não estava instalado
**Solução:** Instalamos com `rustup target add wasm32v1-none`

### **4. Identidades Duplicadas**
**Problema:** Identidade "bob" duplicada
**Solução:** Removemos e criamos nova identidade "alice"

## 📊 **Resultados Finais**

### **Contratos Deployados com Sucesso:**

| Contrato | ID | Status |
|----------|----|--------|
| **Flipper** | `CDKIYA6SKF7YVPIJKTQZG47FMCZFI6KCGKERBSYXWJ6C7FUI4O4ILV7L` | ✅ Funcionando |
| **Increment** | `CDCU2ULOOGZCMPIAPCB7CJNGMKQVHTQNPXXZ2DO5BKQSV4L4XYMTOR46` | ✅ Funcionando |
| **Task Manager** | `CBIX5J5IVQKAQUD2VJLPNEXMIZEUUONURGIPCNBNPICDZ4NUEJ4SNRKA` | ✅ Funcionando |

### **Ambiente Configurado:**
- ✅ Node Stellar local funcionando
- ✅ Friendbot habilitado
- ✅ Soroban CLI atualizado
- ✅ Contratos compilados e testados
- ✅ Interações completas realizadas

## 🎓 **Conhecimentos Adquiridos**

### **Técnicos:**
- Desenvolvimento de smart contracts em Rust
- Uso do Soroban SDK
- Compilação para WASM
- Deploy e interação com contratos
- Gerenciamento de estado persistente

### **Práticos:**
- Configuração de ambiente de desenvolvimento
- Troubleshooting de problemas comuns
- Uso da CLI Soroban atualizada
- Testes de funcionalidade
- Documentação de processos

### **Conceituais:**
- Arquitetura de smart contracts
- Padrões de armazenamento
- Tratamento de erros
- Operações CRUD em blockchain
- Gerenciamento de ciclo de vida

## 🚀 **Próximos Passos**

Com base no que aprendemos, podemos avançar para:
- **Aula 5:** Noções avançadas de Soroban
- **Contratos mais complexos:** DeFi, NFTs, Tokens
- **Integração com frontend:** Web3 applications
- **Testes automatizados:** Unit tests e integration tests
- **Deploy em testnet/mainnet:** Ambientes de produção

---

## 📝 **Notas Importantes**

1. **Sempre verificar a versão da CLI** antes de usar comandos
2. **O friendbot é essencial** para desenvolvimento local
3. **Target WASM correto** é necessário para compilação
4. **Identidades únicas** evitam conflitos
5. **Testes incrementais** garantem funcionamento correto

---

**Status da Aula 4:** ✅ **COMPLETA E FUNCIONAL**



## 1. config networking

```
soroban config network add local \
    --rpc-url "http://localhost:8000/soroban/rpc" \
    --network-passphrase "Standalone Network ; February 2017"
```

## 2. config wallet

```
soroban keys generate --global bob --network local
```

## 3. build smartcontracts

```
soroban contract build
```

## 4. deploy smartcontract

```
soroban contract deploy \
  --wasm target/wasm32-unknown-unknown/release/<CONTRACT_NAME>.wasm \
  --source bob \
  --network local
```

## 5. interact with smartcontract

```
soroban contract invoke \
  --id <CONTRACT_ID> \
  --source bob \
  --network local \
  -- \
  hello \
  --to Lucas
```

```bash
soroban contract invoke \
  --id CDGRZ4K2YZAP2LWU5XTCAQM3AF5MD4QWY6KZO274OJ7PSFW6BJIRQPDV \
  --source bob \
  --network local \
  -- \
  get_all_tasks
```

```bash
soroban contract invoke \
  --id CDGRZ4K2YZAP2LWU5XTCAQM3AF5MD4QWY6KZO274OJ7PSFW6BJIRQPDV \
  --source bob \
  --network local \
  -- \
  add_task \
  --name Limpar_o_carro
```

```bash
soroban contract invoke \
  --id CDGRZ4K2YZAP2LWU5XTCAQM3AF5MD4QWY6KZO274OJ7PSFW6BJIRQPDV \
  --source bob \
  --network local \
  -- \
  complete_task \
  --id 1
```

```bash
soroban contract invoke \
  --id CDGRZ4K2YZAP2LWU5XTCAQM3AF5MD4QWY6KZO274OJ7PSFW6BJIRQPDV \
  --source bob \
  --network local \
  -- \
  delete_task \
  --id 12
```


# NOVOS COMANDOS DO SOROBAN (Versão Atualizada)

## Passo a Passo Completo - Soroban CLI Atualizado

### 1. Configurar Rede e Gerar Identidade

```bash
# Gerar uma nova identidade (chave) para a rede local
soroban keys generate bob --rpc-url "http://localhost:8000/soroban/rpc" --network-passphrase "Standalone Network ; February 2017"

# Verificar se a identidade foi criada
soroban keys ls
```

### 2. Fundar a Conta (Adicionar Saldo)

```bash
# Fundar a conta para ter saldo para transações
soroban keys fund bob --rpc-url "http://localhost:8000/soroban/rpc" --network-passphrase "Standalone Network ; February 2017"
```

### 3. Compilar os Contratos

```bash
# Compilar todos os contratos do projeto
soroban contract build

# Verificar se os arquivos WASM foram gerados
ls -la target/wasm32-unknown-unknown/release/
```

### 4. Deploy dos Contratos

```bash
# Deploy do contrato Flipper
soroban contract deploy \
  --wasm target/wasm32-unknown-unknown/release/flipper.wasm \
  --source bob \
  --rpc-url "http://localhost:8000/soroban/rpc" \
  --network-passphrase "Standalone Network ; February 2017"

# Deploy do contrato Increment
soroban contract deploy \
  --wasm target/wasm32-unknown-unknown/release/increment.wasm \
  --source bob \
  --rpc-url "http://localhost:8000/soroban/rpc" \
  --network-passphrase "Standalone Network ; February 2017"

# Deploy do contrato Task Manager
soroban contract deploy \
  --wasm target/wasm32-unknown-unknown/release/task_manager.wasm \
  --source bob \
  --rpc-url "http://localhost:8000/soroban/rpc" \
  --network-passphrase "Standalone Network ; February 2017"
```

### 5. Interação com os Contratos

#### Flipper Contract
```bash
# Verificar estado inicial
soroban contract invoke \
  --id <CONTRACT_ID_FLIPPER> \
  --source bob \
  --rpc-url "http://localhost:8000/soroban/rpc" \
  --network-passphrase "Standalone Network ; February 2017" \
  -- \
  get_state

# Inverter o estado
soroban contract invoke \
  --id <CONTRACT_ID_FLIPPER> \
  --source bob \
  --rpc-url "http://localhost:8000/soroban/rpc" \
  --network-passphrase "Standalone Network ; February 2017" \
  -- \
  flip
```

#### Increment Contract
```bash
# Verificar contador inicial
soroban contract invoke \
  --id <CONTRACT_ID_INCREMENT> \
  --source bob \
  --rpc-url "http://localhost:8000/soroban/rpc" \
  --network-passphrase "Standalone Network ; February 2017" \
  -- \
  get_counter

# Incrementar o contador
soroban contract invoke \
  --id <CONTRACT_ID_INCREMENT> \
  --source bob \
  --rpc-url "http://localhost:8000/soroban/rpc" \
  --network-passphrase "Standalone Network ; February 2017" \
  -- \
  increment
```

#### Task Manager Contract
```bash
# Listar todas as tarefas (inicialmente vazio)
soroban contract invoke \
  --id <CONTRACT_ID_TASK_MANAGER> \
  --source bob \
  --rpc-url "http://localhost:8000/soroban/rpc" \
  --network-passphrase "Standalone Network ; February 2017" \
  -- \
  get_all_tasks

# Adicionar uma nova tarefa
soroban contract invoke \
  --id <CONTRACT_ID_TASK_MANAGER> \
  --source bob \
  --rpc-url "http://localhost:8000/soroban/rpc" \
  --network-passphrase "Standalone Network ; February 2017" \
  -- \
  add_task \
  --name "Limpar_o_carro"

# Marcar tarefa como concluída
soroban contract invoke \
  --id <CONTRACT_ID_TASK_MANAGER> \
  --source bob \
  --rpc-url "http://localhost:8000/soroban/rpc" \
  --network-passphrase "Standalone Network ; February 2017" \
  -- \
  complete_task \
  --id 1

# Deletar uma tarefa
soroban contract invoke \
  --id <CONTRACT_ID_TASK_MANAGER> \
  --source bob \
  --rpc-url "http://localhost:8000/soroban/rpc" \
  --network-passphrase "Standalone Network ; February 2017" \
  -- \
  delete_task \
  --id 1
```

### 6. Comandos Úteis

```bash
# Verificar identidades disponíveis
soroban keys ls

# Ver endereço de uma identidade
soroban keys address bob

# Verificar logs de transações
soroban events --rpc-url "http://localhost:8000/soroban/rpc" --network-passphrase "Standalone Network ; February 2017"

# Obter ajuda sobre um contrato específico
soroban contract invoke --id <CONTRACT_ID> --source bob --rpc-url "http://localhost:8000/soroban/rpc" --network-passphrase "Standalone Network ; February 2017" -- --help
```

### 7. Troubleshooting

#### Se a conta não for fundada:
```bash
# Verificar se o friendbot está funcionando
curl -s http://localhost:8000/friendbot?addr=<SEU_ENDERECO>

# Se não funcionar, verificar se o node está rodando
curl -s http://localhost:8000/ | head -5
```

#### Se houver erro de rede:
```bash
# Verificar se o docker está rodando
docker compose ps

# Reiniciar o ambiente se necessário
docker compose down
docker compose up -d
```

### 8. Variáveis de Ambiente (Opcional)

Para facilitar, você pode definir variáveis de ambiente:

```bash
export STELLAR_RPC_URL="http://localhost:8000/soroban/rpc"
export STELLAR_NETWORK_PASSPHRASE="Standalone Network ; February 2017"

# Então usar comandos mais simples:
soroban keys generate bob
soroban contract deploy --wasm target/wasm32-unknown-unknown/release/flipper.wasm --source bob
```