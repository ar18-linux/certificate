#!/usr/bin/expect -f

set dry_run [lindex $argv 0];
set email [lindex $argv 1];
set domain [lindex $argv 2];

set timeout -1

spawn certbot certonly --standalone "$dry_run"
expect {
  "Enter email address" {
    send -- "$email\r"
    exp_continue
  }
  "Do you agree" {
    send -- "Y\r"
    exp_continue
  }
  "Please enter the domain name" {
    send -- "$domain\r"
    exp_continue
  }
  "error: target not found" {
    exit 1
  }
}
