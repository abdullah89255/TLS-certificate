#!/bin/bash

# ===== Certificate Reader Script =====
# Usage: ./read_cert.sh cert.pem

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <certificate.pem>"
  exit 1
fi

CERT="$1"

if [[ ! -f "$CERT" ]]; then
  echo "[!] Certificate file not found!"
  exit 1
fi

echo "======================================="
echo " 🔐 TLS CERTIFICATE ANALYSIS"
echo "======================================="
echo

echo "[+] BASIC INFORMATION"
openssl x509 -in "$CERT" -noout -subject -issuer
echo

echo "[+] VALIDITY PERIOD"
openssl x509 -in "$CERT" -noout -dates
echo

echo "[+] PUBLIC KEY & SIGNATURE"
openssl x509 -in "$CERT" -noout -text | grep -E "Public Key Algorithm|Signature Algorithm" | head -n 5
echo

echo "[+] SUBJECT ALTERNATIVE NAMES (SAN)"
openssl x509 -in "$CERT" -noout -ext subjectAltName
echo

echo "[+] EXTENDED KEY USAGE"
openssl x509 -in "$CERT" -noout -ext extendedKeyUsage 2>/dev/null
echo

echo "[+] FULL HUMAN-READABLE OUTPUT"
echo "---------------------------------------"
openssl x509 -in "$CERT" -text -noout
echo

echo "======================================="
echo " ✅ ANALYSIS COMPLETE"
echo "======================================="
