tag ?= latest
clean-cmd = docker compose down --remove-orphans --volumes

copy-kubernetes-configuration:
	docker compose cp kubernetes:/tmp/kubernetes/k3s.yaml .
	@echo "export KUBECONFIG=$(PWD)/k3s.yaml"

init-storage:
	mkdir -p k3s-storage
	chmod -R ug+rwx k3s-storage/

clean-storage:
	rm -rf k3s-storage/*

shutdown-cluster:
	docker compose down

clean:
	$(clean-cmd)

cluster:
	docker compose up -d kubernetes
	timeout 20s bash -c "until docker compose cp kubernetes:/tmp/kubernetes/k3s.yaml .; do echo \"Waiting for kubernetes...\" && sleep 1; done;"
	timeout 1m bash -c "until kubectl --kubeconfig ./k3s.yaml get node; do sleep 1; done"

	@echo "export KUBECONFIG=$(PWD)/k3s.yaml"

.PHONY: clean copy-kubernetes-configuration init-storage clean-storage cluster shutdown-cluster
