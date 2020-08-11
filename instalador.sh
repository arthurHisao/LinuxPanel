#! /bin/bash

#diretorio /opt/LinuxPanel
dir=/opt/LinuxPanel
#cdir assume o resultado do comando pwd
cdir=$(pwd)
#nome do app
name='/LinuxPanel.tar'
#nome da pasta
folderName='/scripts';
#variavel para concatenar resultado do "pwd" com /LinuxPanel.jar
concat="${cdir} ${name}"
#variavel para concatenar resultado do "pwd" com nome da pasta /scripts
concatFolder="${cdir} ${folderName}"
#removendo o espaço 
app=$(echo -n "${concat//[[:space:]]/}")
#removendo o espaço da segunda variavel
script=$(echo -n "${concatFolder//[[:space:]]/}")

#verificando a existencia da pasta 
if [ -d $dir ] 
then
	echo "$dir Já existe."
	read -p "Gostaria de Desinstalar? s ou n: " s n
	if [[ $s == "s" ]]; then
		sudo rm -r /usr/bin/linux-panel
		sudo rm -r /usr/share/applications/LinuxPanel.desktop
		sudo rm -r /opt/LinuxPanel
		sudo cp /etc/hosts.bkp /etc/hosts
		sleep 1		
		echo "Desinstalado com sucesso!"
		sleep 2	
		exit
	else 
		echo "cancelado"
		exit	
	fi
else
	echo "Para funcionar alguns recursos será necessário instalar "
	echo "alguns programas"
	#atualizando os repositorios
	sudo apt-get update && apt-get upgrade
	#instalando o java
	sudo apt-get install default-jre
	sleep 1	
	clear
	echo "$dir Não existe em seguida será criado a pasta"
	sleep 2
	clear
	echo "Em seguida informe a senha"
	echo "A senha é muito importante para fazer instalações"
	echo "O arquivo LinuxPanel.tar será extraido"
	sleep 3
	#extrai o arquivo para pasta /opt diretorio padrao sera /opt/LinuxPanel"	
	sudo tar -xf $app -C /opt
	#alterando a permissao para tornar arquivo accessivel
	chmod 777 /opt/LinuxPanel/linux-panel 
	#alterando a permissao para tornar arquivo accessivel
	chmod 777 /opt/LinuxPanel/LinuxPanel.desktop	
	sleep 2	
	clear	
	#echo "Em seguida informe a senha"
	echo "Em seguida os arquivos de configurações serão movidas na pasta correta"
	sleep 4
	#movendo o arquivo executavel (.sh)
	sudo mv /opt/LinuxPanel/linux-panel /usr/bin
	#movendo o arquivo executavel este aparece na barra de pesquisa
	sudo mv /opt/LinuxPanel/LinuxPanel.desktop /usr/share/applications/LinuxPanel.desktop	
	sleep 3
	clear	
	#echo "Em seguida informe a senha para fazer o backup do arquivo hosts"		
	sudo chmod 777 /etc/hosts
	sudo touch /etc/hosts.bkp
	sudo cp /etc/hosts /etc/hosts.bkp		
	echo "Pronto!"
	sleep 2
fi
