function lazydocker --description 'Run lazydocker ensuring OrbStack is running'
    # Check if OrbStack is running
    if not pgrep -x OrbStack >/dev/null
        echo "OrbStack is not running. Starting it..."
        open -a OrbStack
        
        echo "Waiting for Docker engine..."
        # Loop until docker info succeeds or timeout (30 seconds)
        set -l retries 0
        while not docker info >/dev/null 2>&1
            sleep 1
            set retries (math $retries + 1)
            if test $retries -ge 30
                echo "Timed out waiting for Docker."
                return 1
            end
        end
    end
    
    command lazydocker $argv
end
