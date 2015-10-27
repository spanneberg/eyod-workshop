# Central GitLab instance
node 'ip-172-31-8-80' {
  include ::roles::git_repo_server
}

node 'ip-172-31-29-191' {
  include ::roles::ci_master_and_artifact_repo 
}

node 'ip-172-31-2-196' {
  include ::roles::ci_slave_and_sonarqube 
}
