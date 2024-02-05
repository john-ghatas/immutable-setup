#!/bin/bash
CONTAINER=(general rstudio ubuntu development)

# All binaries and apps from each container
APPS_GENERAL=(thunderbird)
APPS_RSTUDIO=(rstudio)
APPS_UBUNTU=(intellij-idea-community)
APPS_DEVELOPMENT=(codium)

BIN_DEVELOPMENT=(/usr/bin/jq /usr/bin/nc /usr/bin/tig /usr/bin/ansible-playbook /usr/bin/ansible-galaxy /usr/local/bin/kind /usr/local/bin/kubectl)


for env in "${CONTAINER[@]}"
do
	echo "Exporting the apps for $env"
	declare -n APPS_ARR=APPS_${env^^}
	if [ -n "${!APPS_ARR}" ]; then
		echo "Found applications to export for $env"
		for application in "${APPS_ARR[@]}"; do distrobox-enter -n $env -- distrobox-export --app $application -d; done
		for application in "${APPS_ARR[@]}"; do distrobox-enter -n $env -- distrobox-export --app $application; done
	fi

	echo "Exporting the apps for $env"
	declare -n BIN_ARR=BIN_${env^^}
	if [ -n "${!BIN_ARR}" ]; then
		echo "Found binaries to export for $env"
		for binary in "${BIN_ARR[@]}"; do distrobox-enter -n $env -- distrobox-export --bin $binary --export-path ~/.local/bin -d; done
		for binary in "${BIN_ARR[@]}"; do distrobox-enter -n $env -- distrobox-export --bin $binary --export-path ~/.local/bin; done
	fi
done
