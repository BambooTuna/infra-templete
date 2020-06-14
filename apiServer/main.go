package main

import (
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	"net/http"
	"sync"
	"time"

	"github.com/BambooTuna/go-server-lib/metrics"
)

const namespace = "k8s_infra"

func main() {
	wg := new(sync.WaitGroup)
	wg.Add(3)

	m := metrics.CreateMetrics(namespace)
	go func() {
		health := m.Gauge("health", map[string]string{})
		health.Set(200)
		ticker := time.NewTicker(time.Minute * 1)
		defer ticker.Stop()
		for {
			select {
			case <-ticker.C:
				health.Set(200)
			}
		}
	}()

	// monitoring metrics, process
	go func() {
		processCollector := prometheus.NewProcessCollector(prometheus.ProcessCollectorOpts{Namespace: namespace})
		prometheus.MustRegister(m, processCollector)
		http.Handle("/metrics", promhttp.Handler())
		_ = http.ListenAndServe(":2112", nil)
		wg.Done()
	}()
	wg.Wait()
}
