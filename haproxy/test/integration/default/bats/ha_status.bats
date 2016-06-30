@test "haproxy installed" {
  run which haproxy
  [ "$status" -eq 0 ]
}
@test "haproxy service is runnig'" {
 run bash -c "service haproxy status | cut -d' ' -f6"

    [ $output = "running..." ]
}
