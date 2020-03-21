up:
	@vagrant up --provider virtualbox
	@vagrant ssh

ssh:
	@vagrant ssh

down:
	@vagrant halt

destroy:
	@vagrant destroy -f 

