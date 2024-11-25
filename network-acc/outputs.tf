output "hook_remote_from_master" {
  value = data.terraform_remote_state.master.outputs.bridge-test
}