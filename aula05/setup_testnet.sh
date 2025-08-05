#!/bin/bash

# 🚀 Script de Configuração Rápida para Testnet
# Autor: NearX Stellar Bootcamp

echo "🚀 Configurando ambiente para testnet..."

# Verificar se o Soroban CLI está instalado
if ! command -v soroban &> /dev/null; then
    echo "❌ Soroban CLI não encontrado. Instale primeiro:"
    echo "   https://soroban.stellar.org/docs/getting-started/setup"
    exit 1
fi

echo "✅ Soroban CLI encontrado"

# Configurar rede testnet
echo "📡 Configurando rede testnet..."
soroban config network add testnet \
    --rpc-url "https://soroban-testnet.stellar.org" \
    --network-passphrase "Test SDF Network ; September 2015"

# Definir testnet como padrão
soroban config network set testnet

echo "✅ Testnet configurada"

# Configurar aliases (opcional)
echo "🔧 Configurando aliases..."
echo "" >> ~/.zshrc
echo "# Soroban CLI Aliases" >> ~/.zshrc
echo "alias ska='soroban keys address '" >> ~/.zshrc
echo "alias skl='soroban keys ls '" >> ~/.zshrc
echo "alias scd='soroban contract deploy '" >> ~/.zshrc
echo "alias sci='soroban contract invoke '" >> ~/.zshrc

echo "✅ Aliases configurados no ~/.zshrc"
echo "   Recarregue o terminal com: source ~/.zshrc"

# Verificar configuração
echo ""
echo "📋 Configuração atual:"
soroban config network ls

echo ""
echo "🎉 Configuração concluída!"
echo "   Agora você pode executar: ./testnet_test.sh" 