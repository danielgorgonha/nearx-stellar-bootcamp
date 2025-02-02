## Federated Byzantine Agreement (FBA)

O **Federated Byzantine Agreement (FBA)** é um protocolo de consenso utilizado em redes descentralizadas, como a rede Stellar e o XRP Ledger. Ele é uma variação do problema dos generais bizantinos, que é um experimento mental que ilustra a dificuldade de alcançar consenso em um sistema distribuído com falhas bizantinas.

### Principais Características do FBA:

- **Quóruns e Fatias:** Em vez de exigir que todos os nós concordem, o FBA permite que cada nó decida quais outros nós ele considera confiáveis. Esses nós confiáveis formam "quóruns", e cada nó tem uma "fatia de quórum" que é a combinação de nós confiáveis que ele precisa para alcançar consenso.

- **Consenso Flexível:** O FBA permite que novos nós se juntem à rede sem a necessidade de um consenso unânime. Isso promove o crescimento orgânico da rede e reduz a barreira de entrada2.

- **Tolerância a Falhas:** O protocolo é projetado para ser tolerante a falhas, o que significa que ele pode continuar a operar mesmo se alguns nós falharem ou agirem de forma maliciosa.

- **Segurança e Confiabilidade:** O FBA garante que todos os nós concordem com o mesmo conjunto de transações, prevenindo ataques de gasto duplo e garantindo a integridade das transações.

### Exemplo de Implementação:

O **Stellar Consensus Protocol (SCP)** é uma implementação do FBA. No SCP, cada nó decide quais outros nós ele confia e forma um conjunto de quóruns com base nessa confiança3. O protocolo garante que qualquer combinação de nós dentro desses quóruns concorde para alcançar consenso.

#### Vantagens do FBA:

- **Baixa Barreira de Entrada:** Comparado a outros protocolos de consenso como Proof of Work (PoW) e Proof of Stake (PoS), o FBA tem requisitos computacionais e financeiros menores, facilitando a entrada de novos participantes.

- **Descentralização:** O FBA permite um controle descentralizado, onde nenhum nó central decide quem deve participar do consenso.

- **Segurança:** O protocolo é projetado para ser seguro e tolerante a falhas, garantindo a integridade das transações.