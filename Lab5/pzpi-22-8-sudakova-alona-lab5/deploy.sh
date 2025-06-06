!/bin/bash

echo "Starting FocusLearn deployment..."

# Кольори для виводу
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Функція логування
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}"
}

warning() {
    echo -e "${YELLOW}[WARNING] $1${NC}"
}

# Перевірка передумов
check_prerequisites() {
    log "Checking prerequisites..."
    
    # Перевірка .NET
    if ! command -v dotnet &> /dev/null; then
        error ".NET SDK is not installed"
        exit 1
    fi
    
    # Перевірка Node.js
    if ! command -v node &> /dev/null; then
        error "Node.js is not installed"
        exit 1
    fi
    
    # Перевірка SQL Server
    if ! command -v sqlcmd &> /dev/null; then
        warning "SQL Server command line tools not found"
    fi
    
    log "Prerequisites check completed"
}

# Розгортання серверної частини
deploy_server() {
    log "Deploying server..."
    
    cd focuslearn-server || exit 1
    
    # Відновлення пакетів
    dotnet restore
    if [ $? -ne 0 ]; then
        error "Failed to restore server packages"
        exit 1
    fi
    
    # Оновлення бази даних
    dotnet ef database update
    if [ $? -ne 0 ]; then
        error "Failed to update database"
        exit 1
    fi
    
    # Запуск сервера в фоновому режимі
    nohup dotnet run > server.log 2>&1 &
    SERVER_PID=$!
    echo $SERVER_PID > server.pid
    
    # Очікування запуску
    sleep 10
    
    # Перевірка запуску
    if curl -k -s https://localhost:7124/api/ConcentrationMethods > /dev/null; then
        log "Server started successfully"
    else
        error "Server failed to start"
        exit 1
    fi
    
    cd ..
}

# Розгортання веб-клієнта
deploy_client() {
    log "Deploying web client..."
    
    cd focuslearn-client || exit 1
    
    # Встановлення залежностей
    npm install
    if [ $? -ne 0 ]; then
        error "Failed to install client dependencies"
        exit 1
    fi
    
    # Запуск клієнта в фоновому режимі
    nohup npm start > client.log 2>&1 &
    CLIENT_PID=$!
    echo $CLIENT_PID > client.pid
    
    # Очікування запуску
    sleep 15
    
    # Перевірка запуску
    if curl -s http://localhost:3000 > /dev/null; then
        log "Web client started successfully"
    else
        error "Web client failed to start"
        exit 1
    fi
    
    cd ..
}

# Головна функція
main() {
    log "Starting FocusLearn deployment process..."
    
    check_prerequisites
    deploy_server
    deploy_client
    
    log "🎉 Deployment completed successfully!"
    log "Server: https://localhost:7124"
    log "Client: http://localhost:3000"
    log "Swagger: https://localhost:7124/swagger"
    
    log "To stop services:"
    log "kill \$(cat focuslearn-server/server.pid)"
    log "kill \$(cat focuslearn-client/client.pid)"
}

# Обробка сигналів
cleanup() {
    log "Cleaning up..."
    if [ -f focuslearn-server/server.pid ]; then
        kill $(cat focuslearn-server/server.pid) 2>/dev/null
        rm focuslearn-server/server.pid
    fi
    if [ -f focuslearn-client/client.pid ]; then
        kill $(cat focuslearn-client/client.pid) 2>/dev/null
        rm focuslearn-client/client.pid
    fi
    exit 0
}

trap cleanup INT TERM

# Запуск
main "$@"
bashchmod +x deploy.sh
./deploy.sh
