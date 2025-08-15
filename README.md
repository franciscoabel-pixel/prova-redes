# Projeto de Automação de Infraestrutura - Debian

Este repositório contém um script de automação para configuração inicial de um servidor **Debian**, incluindo instalação e configuração de pacotes essenciais, criação de usuários, permissões, cotas de disco e outros ajustes necessários para o ambiente.

## 📂 Conteúdo do Repositório

- `setup_infra.sh` — Script principal de automação.
- `index.html` — Página de exemplo para teste do servidor web.
- `README.md` — Documento explicativo do projeto.
______________________________________________________________________
## 🚀 Como Executar o Script

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git
   cd SEU_REPOSITORIO
   
2. Dê permição para executar o script:

---->> chmod +x setup_infra.sh

3. Execute o script como root:

---->> sudo ./setup_infra.sh
_____________________________________________________________________
🛠 Recursos e Funcionalidades

- Instalação automática de pacotes essenciais.
- Configuração de servidor web com página de teste.
- Criação de usuários e grupos.
- Configuração de cotas de disco.
- Ajustes no /etc/fstab para ativar cotas.
- Personalização básica do sistema.

📌 Requisitos

- Debian (versão 12 ou superior).
- Acesso root ou usuário com privilégios sudo.
- Conexão com a internet.
