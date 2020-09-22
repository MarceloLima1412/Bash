#!/usr/bin/env bash

help() {
   #Mostra a ajuda
    echo "-h: show help";
    echo "-i: fetch CGD's file from Internet";
	 echo "-d: remove directory ARQUIVO";
}

removeold(){
	if [ "$(ls | grep fundos_CGD_*.html)" = "fundos_CGD_*.html" ]; then
	#Remove todos os ficheiros antigos 
	rm fundos_CGD_*.html
	fi
}

removearq(){
	if [ "$(ls | grep ARQUIVO)" = "ARQUIVO" ]; then
	rm -r ARQUIVO
	echo "[Sucesso]: Pasta ARQUIVO removida com sucesso"
	else
	echo "[Erro]: Pasta ARQUIVO não existe"
	fi
}

downloadpage(){
   #Download da pagina web
   wget https://www.cgd.pt/Particulares/Poupanca-Investimento/Fundos-de-Investimento/Pages/CotacoeseRendibilidades.aspx -O fundos_CGD_$(date +"%Y%m%d").html
}

extractdata(){
	#extrai os valores da data
   cat fundos_CGD_$(date +"%Y%m%d").html | grep -E "(Classe de risco 60 meses)" | tr "x" "*" | cut -d* -f30- | tr ">" "*" | cut -d* -f2- | tr "<" "*" | cut -d* -f-1
}
  
extracteu() {
   #extrai valores do ficheiro fundos_CGD na linha das Europa
   #Cx Ações Europa Soc Resp -> cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEuropa
	europadata="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEuropa | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r" )"  
   europadata1="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEuropa | head -n 5 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r" )"
	europadata12="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEuropa | head -n 7 | tail -n 1 | tr -d " " | cut -d [ -f 1 | tr "," "." | tr -d "\r" )"
	europadata24="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEuropa | head -n 9 | tail -n 1 | tr -d " " | cut -d [ -f 1 | tr "," "." | tr -d "\r" )"
	
	#mostra os valores extraidos
	echo "EU|$europadata|$europadata1|$europadata12|$europadata24|"
}	

extracteua() {
	#extrai valores do ficheiro fundos_CGD na linha dos EUA
   #Cx Ações EUA -> cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEUA
   euadata="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEUA | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r" )"  
   euadata1="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEUA | head -n 5 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r" )"
	euadata12="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEUA | head -n 7 | tail -n 1 | tr -d " " | cut -d [ -f 1 | tr "," "." | tr -d "\r" )"
	euadata24="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEUA | head -n 9 | tail -n 1 | tr -d " " | cut -d [ -f 1 | tr "," "." | tr -d "\r" )"
	
	#mostra os valores extraidos
	echo "EUA|$euadata|$euadata1|$euadata12|$euadata24|"
}

extractpt() {
	#extrai valores do ficheiro fundos_CGD na linha de Portugal
   #Cx Ações Portugal Espanha -> cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesPortugal
	ptdata="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesPortugal | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r" )"  
   ptdata1="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesPortugal | head -n 5 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r" )"
	ptdata12="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesPortugal | head -n 7 | tail -n 1 | tr -d " " | cut -d [ -f 1 | tr "," "." | tr -d "\r" )"
	ptdata24="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesPortugal | head -n 9 | tail -n 1 | tr -d " " | cut -d [ -f 1 | tr "," "." | tr -d "\r" )"

	#mostra os valores extraidos
	echo "PT|$ptdata|$ptdata1|$ptdata12|$ptdata24|"
}

extractori() {
	#extrai valores do ficheiro fundos_CGD na linha do Oriente
   #Cx Ações Oriente -> cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesOriente
	oridata="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesOriente | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r" )"  
   oridata1="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesOriente | head -n 5 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r" )"
	oridata12="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesOriente | head -n 7 | tail -n 1 | tr -d " " | cut -d [ -f 1 | tr "," "." | tr -d "\r" )"
	oridata24="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesOriente | head -n 9 | tail -n 1 | tr -d " " | cut -d [ -f 1 | tr "," "." | tr -d "\r" )"

	#mostra os valores extraidos
	echo "ORI|$oridata|$oridata1|$oridata12|$oridata24|"   
}

extractemer() {
	#extrai valores do ficheiro fundos_CGD na linha das Ações Emergentes
   #Cxg Ações Emergentes -> cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEmergentes
	emerdata="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEmergentes | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r" )"  
   emerdata1="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEmergentes | head -n 5 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r" )"
	emerdata12="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEmergentes | head -n 7 | tail -n 1 | tr -d " " | cut -d [ -f 1 | tr "," "." | tr -d "\r" )"
	emerdata24="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEmergentes | head -n 9 | tail -n 1 | tr -d " " | cut -d [ -f 1 | tr "," "." | tr -d "\r" )"

	#mostra os valores extraidos
	echo "EMER|$emerdata|$emerdata1|$emerdata12|$emerdata24|"
}

extractglob() {
	#extrai valores do ficheiro fundos_CGD na linha dos Lideres Globais
   #Cx Ações Líderes Globais -> cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAcoesLideresGlobais
	globdata="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAcoesLideresGlobais | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r" )"  
   globdata1="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAcoesLideresGlobais | head -n 5 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r" )"
	globdata12="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAcoesLideresGlobais | head -n 7 | tail -n 1 | tr -d " " | cut -d [ -f 1 | tr "," "." | tr -d "\r" )"
	globdata24="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAcoesLideresGlobais | head -n 9 | tail -n 1 | tr -d " " | cut -d [ -f 1 | tr "," "." | tr -d "\r" )"

	#mostra os valores extraidos
	echo "GLOB|$globdata|$globdata1|$globdata12|$globdata24|"
}

extractreforma() {
	#extrai valores do ficheiro fundos_CGD na linha da Reforma Ativa
   #Caixa Reforma Ativa -> cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixaReformaActiva
	reformadata="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixaReformaActiva | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r" )"  
   reformadata1="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixaReformaActiva | head -n 5 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r" )"
	reformadata12="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixaReformaActiva | head -n 7 | tail -n 1 | tr -d " " | cut -d [ -f 1 | tr "," "." | tr -d "\r" )"
	reformadata24="$(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixaReformaActiva | head -n 9 | tail -n 1 | tr -d " " | cut -d [ -f 1 | tr "," "." | tr -d "\r" )"

	#mostra os valores extraidos
	echo "REFORMA|$reformadata|$reformadata1|$reformadata12|$reformadata24|"

}

verificadir(){
	#verifica se existe a diretoria ARQUIVO
	if [ "$(ls | grep ARQUIVO)" != "ARQUIVO" ]; then
	#se não existir, cria
	mkdir ARQUIVO 
	fi
}

insertdateu(){
	#verifica se existe um ficheiro eu.dat
	if [ "$(ls ARQUIVO/ | grep EU.dat)" != "EU.dat" ]; then
	#se não existir, cria um com os nossos nomes e o primeiro registo
		echo "#Dados para o fundo EU" >> ARQUIVO/EU.dat
		echo "#MARCELO_LIMA/2160886" >> ARQUIVO/EU.dat
		echo "#RUBEN_OLIVEIRA/2192236" >> ARQUIVO/EU.dat
		echo "Criado: $(date +"%Y.%m.%d_%H"h":%M:%S")" >> ARQUIVO/EU.dat
		echo "$(date +"%Y-%m-%d"): $(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEuropa | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r")" >> ARQUIVO/EU.dat
	elif [ "$(tail -1 ARQUIVO/EU.dat | cut -d : -f1)" != "$(date +"%Y-%m-%d")" ]; then
	#se existir e se a ultima data estiver desatualizada, insere uma linha com a data e o valor que se regista na altura
		echo "$(date +"%Y-%m-%d"): $(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEuropa | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r")" >> ARQUIVO/EU.dat
	fi
}

insertdateua(){
	#verifica se existe um ficheiro eua.dat
	if [ "$(ls ARQUIVO/ | grep EUA.dat)" != "EUA.dat" ]; then
	#se não existir, cria um com os nossos nomes e o primeiro registo
		echo "#Dados para o fundo EUA" >> ARQUIVO/EUA.dat
		echo "#MARCELO_LIMA/2160886" >> ARQUIVO/EUA.dat
		echo "#RUBEN_OLIVEIRA/2192236" >> ARQUIVO/EUA.dat
		echo "Criado: $(date +"%Y.%m.%d_%H"h":%M:%S")" >> ARQUIVO/EUA.dat
		echo "$(date +"%Y-%m-%d"): $(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEUA | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r")" >> ARQUIVO/EUA.dat
	elif [ "$(tail -1 ARQUIVO/EUA.dat | cut -d : -f1)" != "$(date +"%Y-%m-%d")" ]; then
	#se existir e se a ultima data estiver desatualizada, insere uma linha com a data e o valor que se regista na altura
		echo "$(date +"%Y-%m-%d"): $(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEUA | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r")" >> ARQUIVO/EUA.dat
	fi
}

insertdatpt(){
	#verifica se existe um ficheiro pt.dat
	if [ "$(ls ARQUIVO/ | grep PT.dat)" != "PT.dat" ]; then
	#se não existir, cria um com os nossos nomes e o primeiro registo
		echo "#Dados para o fundo PT" >> ARQUIVO/PT.dat
		echo "#MARCELO_LIMA/2160886" >> ARQUIVO/PT.dat
		echo "#RUBEN_OLIVEIRA/2192236" >> ARQUIVO/PT.dat
		echo "Criado: $(date +"%Y.%m.%d_%H"h":%M:%S")" >> ARQUIVO/PT.dat
		echo "$(date +"%Y-%m-%d"): $(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesPortugal | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r")" >> ARQUIVO/PT.dat
	elif [ "$(tail -1 ARQUIVO/PT.dat | cut -d : -f1)" != "$(date +"%Y-%m-%d")" ]; then
	#se existir e se a ultima data estiver desatualizada, insere uma linha com a data e o valor que se regista na altura
		echo "$(date +"%Y-%m-%d"): $(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesPortugal | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r")" >> ARQUIVO/PT.dat
	fi
}

insertdatori(){
	#verifica se existe um ficheiro ori.dat
	if [ "$(ls ARQUIVO/ | grep ORI.dat)" != "ORI.dat" ]; then
	#se não existir, cria um com os nossos nomes e o primeiro registo
		echo "#Dados para o fundo ORI" >> ARQUIVO/ORI.dat
		echo "#MARCELO_LIMA/2160886" >> ARQUIVO/ORI.dat
		echo "#RUBEN_OLIVEIRA/2192236" >> ARQUIVO/ORI.dat
		echo "Criado: $(date +"%Y.%m.%d_%H"h":%M:%S")" >> ARQUIVO/ORI.dat
		echo "$(date +"%Y-%m-%d"): $(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesOriente | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r")" >> ARQUIVO/ORI.dat
	elif [ "$(tail -1 ARQUIVO/ORI.dat | cut -d : -f1)" != "$(date +"%Y-%m-%d")" ]; then
	#se existir e se a ultima data estiver desatualizada, insere uma linha com a data e o valor que se regista na altura
		echo "$(date +"%Y-%m-%d"): $(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesOriente | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r")" >> ARQUIVO/ORI.dat
	fi
}

insertdatemer(){
	#verifica se existe um ficheiro emer.dat
	if [ "$(ls ARQUIVO/ | grep EMER.dat)" != "EMER.dat" ]; then
	#se não existir, cria um com os nossos nomes e o primeiro registo
		echo "#Dados para o fundo EMER" >> ARQUIVO/EMER.dat
		echo "#MARCELO_LIMA/2160886" >> ARQUIVO/EMER.dat
		echo "#RUBEN_OLIVEIRA/2192236" >> ARQUIVO/EMER.dat
		echo "Criado: $(date +"%Y.%m.%d_%H"h":%M:%S")" >> ARQUIVO/EMER.dat
		echo "$(date +"%Y-%m-%d"): $(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEmergentes | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r")" >> ARQUIVO/EMER.dat
	elif [ "$(tail -1 ARQUIVO/EMER.dat | cut -d : -f1)" != "$(date +"%Y-%m-%d")" ]; then
	#se existir e se a ultima data estiver desatualizada, insere uma linha com a data e o valor que se regista na altura
		echo "$(date +"%Y-%m-%d"): $(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAccoesEmergentes | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r")" >> ARQUIVO/EMER.dat
	fi
}

insertdatglob(){
	#verifica se existe um ficheiro glob.dat
	if [ "$(ls ARQUIVO/ | grep GLOB.dat)" != "GLOB.dat" ]; then
	#se não existir, cria um com os nossos nomes e o primeiro registo
		echo "#Dados para o fundo GLOB" >> ARQUIVO/GLOB.dat
		echo "#MARCELO_LIMA/2160886" >> ARQUIVO/GLOB.dat
		echo "#RUBEN_OLIVEIRA/2192236" >> ARQUIVO/GLOB.dat
		echo "Criado: $(date +"%Y.%m.%d_%H"h":%M:%S")" >> ARQUIVO/GLOB.dat
		echo "$(date +"%Y-%m-%d"): $(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAcoesLideresGlobais | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r")" >> ARQUIVO/GLOB.dat
	elif [ "$(tail -1 ARQUIVO/GLOB.dat | cut -d : -f1)" != "$(date +"%Y-%m-%d")" ]; then
	#se existir e se a ultima data estiver desatualizada, insere uma linha com a data e o valor que se regista na altura
		echo "$(date +"%Y-%m-%d"): $(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixagestAcoesLideresGlobais | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r")" >> ARQUIVO/GLOB.dat
	fi
}

insertdatreforma(){
	#verifica se existe um ficheiro reforma.dat
	if [ "$(ls ARQUIVO/ | grep REFORMA.dat)" != "REFORMA.dat" ]; then
	#se não existir, cria um com os nossos nomes e o primeiro registo
		echo "#Dados para o fundo REFORMA" >> ARQUIVO/REFORMA.dat
		echo "#MARCELO_LIMA/2160886" >> ARQUIVO/REFORMA.dat
		echo "#RUBEN_OLIVEIRA/2192236" >> ARQUIVO/REFORMA.dat
		echo "Criado: $(date +"%Y.%m.%d_%H"h":%M:%S")" >> ARQUIVO/REFORMA.dat
		echo "$(date +"%Y-%m-%d"): $(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixaReformaActiva | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r")" >> ARQUIVO/REFORMA.dat
	elif [ "$(tail -1 ARQUIVO/REFORMA.dat | cut -d : -f1)" != "$(date +"%Y-%m-%d")" ]; then
	#se existir e se a ultima data estiver desatualizada, insere uma linha com a data e o valor que se regista na altura
		echo "$(date +"%Y-%m-%d"): $(cat fundos_CGD_$(date +"%Y%m%d").html | grep -A 12 CaixaReformaActiva | head -n 3 | tail -n 1 | tr -d " " | tr -d "€" | tr "," "." | tr -d "\r")" >> ARQUIVO/REFORMA.dat
	fi
}

extract(){
	#Todas as funçoes para extrair a informação da pagina
	extractdata 
	echo "Fundo|data|data-1|12meses|24meses"
	extracteu
	extracteua
	extractpt
	extractori
	extractemer
	extractglob
	extractreforma
}

insert(){
	#Todas as funçoes responsaveis para inserir nos arquivos .dat na directoria ARQUIVO
	verificadir
	insertdateu
	insertdateua
	insertdatpt
	insertdatori
	insertdatemer
	insertdatglob
	insertdatreforma
}

extractinsert(){
#Verifica se existe um ficheiro, se sim extrai os valores e insere no ficheiro .dat situado na pasta Arquivo os valores extraidos  
   if [ "$(ls | grep fundos_CGD_$(date +"%Y%m%d").html)" = "fundos_CGD_$(date +"%Y%m%d").html" ]; then
      extract
		insert
   else
#Se não existir ficheiro, apresenta um erro
      echo "[ERRO]: ficheiro ‘fundos_CGD_$(date +"%Y%m%d").html’ não encontrado no diretório local. "
   fi
}

if [ "$2" != "" ]; then #Para ./fundos_CGD.sh com mais de uma opção
#Extrai valores do ficheiro para o ecrã, e insere os valores nos .dat os valores mais recentes
   echo "[ERRO]: selecione apenas uma opção "
elif [ "$1" = "" ]; then #Para ./fundos_CGD.sh sem opção
#Extrai valores do ficheiro para o ecrã, e insere os valores nos .dat os valores mais recentes
   extractinsert
elif [ "$1" = "-i" ]; then #Para ./fundos_CGD.sh -i
#Remove as paginas antigas presentes atualizando para uma nova fazendo download da pagina e extrai os valores para o ecrã
   removeold
	downloadpage
	extract
elif [ "$1" = "-d" ]; then #Para ./fundos_CGD.sh -d
#Remove a pasta arquivo se o utilizador quiser criar arquivos novos 
   removearq
elif [ "$1" = "-h" ]; then #Para ./fundos_CGD.sh -h
#Apresenta um manual de ajuda ao utilizador
   help
else 
echo "[Erro]: Consulte a ajuda (-h) para ver as opções"
fi





