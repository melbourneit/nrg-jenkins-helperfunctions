def call(String repoName, String branch, String registryHost) {
  def imageName = registryHost + "/" + repoName
  def safeBranchName = branch.replace("origin/", "").replace("/", "_")

  stage 'Checkout'
  checkout scm

  stage 'Build image'
  def img = docker.build "${imageName}:${safeBranchName}"

  stage 'Push image'
  img.push()

  build job: '/PACKER_TRIGGER_SERVICE_AMI_BY_TAG', wait: false, parameters: [[$class: 'StringParameterValue', name: 'DOCKER_IMAGES_TAG', value: safeBranchName]]
}
