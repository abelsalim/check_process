#!/usr/bin/env bash

# Atribuir permissão de execução.
echo -e "\033[1;32mAtribuindo permissões ao script...\033[0m" && chmod +x check_async.py 

# Mover arquivos para /usr/local/bin.
echo -e "\033[1;32mMovendo arquivos...\033[0m" && mv check_async.py constant.py /usr/local/bin

# Atualizar repositório e instalar python 3.9 junto com o venv.
echo -e "\033[1;32mAtualizando pacotes...\033[0m" && apt-get update
echo -e "\033[1;32mInstalando pacotes python...\033[0m" && apt-get install python3.9 python3.9-venv

# Criar o ambiente virtual.
echo -e "\033[1;32mCriando o ambiente virtual...\033[0m" && python3.9 -m venv /usr/local/bin/env_check

# Instalando psutil.
echo -e "\033[1;32mInstalando psutil...\033[0m"
source /usr/local/bin/env_check/bin/activate && python3.9 -m pip install psutil

# Criar arquivo 'rc.local'.
echo -e "\033[1;32mCriando arquivo rc.local...\033[0m" && touch /etc/rc.local
# Atribuir permissões.
echo -e "\033[1;32mAtribuindo permissões ao arquivo rc.local...\033[0m" && chmod 744 /etc/rc.local

# Adicionar conteúdo ao 'rc.local'.
echo -e "\033[1;32mAdicionando conteúdo ao rc.local...\033[0m"
echo "#!/bin/bash

# Check comunicador
source /usr/local/bin/env_check/bin/activate && /usr/local/bin/check_async.py
" > /etc/rc.local

# Habilitando serviço.
echo -e "\033[1;32mHabilitando serviço...\033[0m" && systemctl enable rc-local > /dev/null 2>&1

# Finalizando!
echo -e "\033[1;37mScript Finalizado, reinicie a máquina!!!\033[0m"
