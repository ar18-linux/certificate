#!/usr/bin/expect -f

set cert_dir [lindex $argv 0];
set domain_or_ip [lindex $argv 1];
set country [lindex $argv 2];
set state [lindex $argv 3];
set locality [lindex $argv 4];
set organization [lindex $argv 5];
set unit [lindex $argv 6];
set common_name [lindex $argv 7];
set email [lindex $argv 8];

set timeout -1

spawn openssl req -new -addext "subjectAltName = DNS:${domain_or_ip}" -key "${cert_dir}/${domain_or_ip}.key" -out "${cert_dir}/${domain_or_ip}.csr"
expect {
  "Country Name" {
    send -- "${country}\r"
    exp_continue
  }
  "State or Province Name" {
    send -- "${state}\r"
    exp_continue
  }
  "Locality Name" {
    send -- "${locality}\r"
    exp_continue
  }
  "Organization Name" {
    send -- "${organization}\r"
    exp_continue
  }
  "Organizational Unit Name" {
    send -- "${unit}\r"
    exp_continue
  }
  "Common Name" {
    send -- "${common_name}\r"
    exp_continue
  }
  "Email Address" {
    send -- "${email}\r"
    exp_continue
  }
  "A challenge password" {
    send -- "\r"
    exp_continue
  }
  "An optional company name" {
    send -- "\r"
    exp_continue
  }
  "error: target not found" {
    exit 1
  }
}
