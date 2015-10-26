node 'gitlab.local' { 
  include ::roles::git_repo_server 
}

node 'ci1.local' { 
  include ::roles::ci_master_and_artifact_repo 
}

node 'ci2.local' {
  # include ::roles::ci_slave_and_sonarqube
}
