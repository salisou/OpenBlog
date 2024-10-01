#--- Symfony-And-Docker-Makefile --------     #
# Autore: Moussa Salisou					  #
# GitHub: https://github.com/salisou     	  #
# Licenza: MIT							      #
###############################################

############################################################################################
# Questo Makefile è stato creato per semplificare l'installazione e la                     #
# configurazione di un progetto Symfony con Docker.										   #
# Per utilizzare questo Makefile, assicurati di avere Docker e Docker Compose              #
# installati sul tuo sistema.															   #
# ecco i link: 									   										   #
# https://www.docker.com/get-started													   #
# https://docs.docker.com/compose/install/												   #
############################################################################################


#-----------------------------------------------
# Apri il bash del tuo progetto con docker
# docker-compose exec php /bin/bash
#-----------------------------------------------

# === VARIABILI  DI CONFIGURAZIONE =================================
# --- DOCKER ---
DOCKER = docker
DOCKER_RUN = $(DOCKER) run
DOCKER_COMPOSE = docker compose
DOCKER_COMPOSE_DOWN = $(DOCKER_COMPOSE) down
DOCKER_COMPOSE_UP = $(DOCKER_COMPOSE) up -d
DOCKER_COMPOSE_BUILD = $(DOCKER_COMPOSE) build
DOCKER_COMPOSE_STOP = $(DOCKER_COMPOSE) stop
# -----------------------------------------------

## === 🆘 HELP ====================================================
help: ## Mostra questo help.
	@echo "Symfony-And-Docker-Makefile"
	@echo "---------------------------"
	@echo "Autore: Moussa Salisou"
	@echo "GitHub: https://github.com/salisou"
	@echo "Licenza: MIT"
	@echo "---------------------------"
	@echo "Informazioni Docker Compose e Docker"
	@echo "Comandi disponibili:"
	@echo "Utilizzo: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
	$(MAKE) v

## === 🐋 DOCKER ================================================
up: ## Funzione per costruire l'immagine Docker.
	$(DOCKER_COMPOSE_UP) --remove-orphans
	@echo "Docker è stato avviato con successo!"
	@echo ""
	@echo "--------------------------------------------------------------"
	@echo "Il tuo progetto è pronto sulla porta http://127.0.0.1:8080/"
	@echo "--------------------------------------------------------------"
	@echo ""
	@echo "Il tuo database è pronto sulla porta http://127.0.0.1:8899/"
	@echo ""
.PHONY: up

v: # Mostra le informazioni sulla versione di Docker Compose
	docker-compose -v
	@echo "---------------------------------------"
	docker -v
	@echo "---------------------------------------"
.PHONY: v

stop: ## Ferma i container Docker.
	$(DOCKER_COMPOSE_STOP)
.PHONY: stop

down: ## Elimina i container.
	$(DOCKER_COMPOSE_DOWN)
.PHONY: down

build: ## Costruisci i container Docker.
	$(DOCKER_COMPOSE_BUILD)
.PHONY: build

docke-cache: ## svuota il cache 
	$(DOCKER) builder prune --all
.PHONY: docke-cache

rest: ## Elimina e ricrea i container Docker.
	$(MAKE) down
	$(MAKE) docke-cache
	$(MAKE) up
	@echo "-----------------------------------------------------------------------"
	@echo "Esegui docker-compose exec php /bin/bash per aprire il tuo app in bash"
.PHONY: rest

