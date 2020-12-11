# k8s-all-in-one
Create a All-in-one Kubernetes Cluster.


# Subir o kubernetes:
  Acesse a raiz do repositorio e rode: 
  
```  
  make up
  
```

ou

```  
  vagrant up --provider virtualbox
```


IP do Servidor: 192.168.1.10

# Monitoramento - Prometheus e Grafana

Para subir a stack de Monitoramento no kubernetes 
Acesse a raiz do repositorio e Execute:

```
kubectl create namespace monitoring

kubectl create -f k8s-prometheus/clusterRole.yaml
kubectl create -f k8s-prometheus/config-map.yaml
kubectl create -f k8s-prometheus/prometheus-deployment.yaml 
kubectl create -f k8s-prometheus/prometheus-service.yaml --namespace=monitoring

kubectl apply -f kube-state-metrics/

kubectl create -f k8s-grafana/
```

Depois acesse http://192.168.1.10:32000/ (Grafana)

Usuario: admin

Senha: admin

Importe o dashboard do GrafanaLabs (https://grafana.com/grafana/dashboards/12740)

ID: 12740

![Image of Dashboard on GrafanaLabs](/monitoring/k8s-grafana/GrafanaDashboardImg.png)

ou copie o conteudo desse arquivo "k8s-grafana/grafana-dashboard-kubernetes.json"
e importe no grafana.


# Links

Para Utilizar é necessario ter instalado:

```  
  Vagrant: https://www.vagrantup.com/

  VirtualBox: https://www.virtualbox.org/

```  
