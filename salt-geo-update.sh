salt -C 'G@vks:system_name:SIL18' test.ping
# systemctl status salt-minion.service # on each one of the 5 geo nodes
salt-run state.orchestrate orchestrator.silhouette.geo.patch_geo_nodes pillar='{"system_name": "SIL18", "ado_number":"ado540849", "check_rpm": "kernel-default-5.3.18-24.96.1.x86_64"}' --log-level=info
