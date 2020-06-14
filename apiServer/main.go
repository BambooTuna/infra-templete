package main

import (
	"fmt"
	"github.com/BambooTuna/go-server-lib/config"
	"github.com/jinzhu/gorm"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	"net/http"
	"sync"
	"time"

	"github.com/BambooTuna/go-server-lib/metrics"

	// mysql driver
	_ "github.com/jinzhu/gorm/dialects/mysql"
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

	connect := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?parseTime=true",
		config.GetEnvString("MYSQL_USER", "user"),
		config.GetEnvString("MYSQL_PASS", "pass"),
		config.GetEnvString("MYSQL_HOST", "127.0.0.1"),
		config.GetEnvString("MYSQL_PORT", "3306"),
		config.GetEnvString("MYSQL_DATABASE", "table"),
	)
	db, _ := gorm.Open("mysql", connect)
	db.Close()


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
