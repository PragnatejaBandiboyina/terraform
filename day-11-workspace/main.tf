resource "aws_s3_bucket" "name" {
    bucket = "teamskyops-multicloud-devops"
  
}
# terraform workspace--> by default our state file will stored into default workspace
# terraform workspace new <ws namme> --> creates a new workspace
# terraform workspace show---> displays the current workspace
# terraform workspace list--> displays all the list of workspaces
# terraform workspace select <ws name>---> to move to a particular workspace
# terraform workspace delete <ws name>---> deletes the particular workspace
         #---> remember that before deleting we need to empty the workspace