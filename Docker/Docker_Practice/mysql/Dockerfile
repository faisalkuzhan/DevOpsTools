FROM mysql:latest

# Özel yapılandırma ayarlarınızı burada belirleyebilirsiniz.
# Örneğin, karakter seti, bağlantı limitleri vb.

# init.sql dosyasını /docker-entrypoint-initdb.d/ dizinine kopyalayın
COPY init.sql /docker-entrypoint-initdb.d/

# Dockerfile'ı oluştururken aşağıdaki komutu kullanarak init.sql dosyasını Docker imajına ekleyebilirsiniz:
# COPY init.sql /docker-entrypoint-initdb.d/

# Docker imajı çalıştırıldığında, init.sql otomatik olarak çalıştırılacaktır.