# kubectl setup

export KUBECONFIG=~/.kube/kubeconfig.yaml

#setup java version

set_java_version() {
    if [ -n "$JAVA_HOME" ]; then
    	# Utworzenie nowej zmiennej PATH bez wartości JAVA_HOME
    	NEW_PATH=$(echo $PATH | tr ':' '\n' | grep -v "$JAVA_HOME/bin" | tr '\n' ':')

    	# Usunięcie ostatniego dwukropka z nowej ścieżki
    	NEW_PATH=${NEW_PATH%:}

    	# Zaktualizowanie zmiennej PATH

  	export PATH=$NEW_PATH
    	echo "Usunięto wartość $JAVA_HOME z PATH."
    else
        echo "JAVA_HOME nie jest ustawione."
    fi
    unset JAVA_HOME
    export JAVA_HOME=$(/usr/libexec/java_home -v $1)
    export PATH=$JAVA_HOME/bin:$PATH
    java -version
}

# Aliasy dla różnych wersji Javy
alias j21="set_java_version 21"
alias j17="set_java_version 17"
alias j11="set_java_version 11"

export GRAALVM_HOME=$(/usr/libexec/java_home -v 21)


# this grants yabai sudo privelaged to reload configuration (a.k.a execute `sudo yabai --load-sa`)
# needs to be execute after yabai has been updated
grant_yabai_privelage() {
  echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /etc/sudoers.d/yabai
}


