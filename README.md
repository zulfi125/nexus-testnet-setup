# 🚀 Nexus Testnet II CLI Setup  
**Author:** [Learn Fast Earn](https://www.youtube.com/@LearnFastEarn2.0)  
**GitHub Repo:** [nexus-testnet-setup](https://github.com/zulfi125/nexus-testnet-setup)  
---
--------------------------------------------------------------------------------------------------------------------------

    
---

## 📜 Installation  
Run the following command to install Nexus CLI:  
```
curl -sSL https://raw.githubusercontent.com/zulfi125/nexus-testnet-setup/main/nexus-setup.sh | bash
```
--------------------------------------------------------------------------------------------------------------------------
1. Press Y for terms
2. ETNER 2 for earn NEX points
3. go to website and create node id and enter node id
   https://app.nexus.xyz

## Fix for `=proto — experimental_allow_proto3_optional orchestrator.proto` Error

If you encounter this error, run the following commands one by one:

### 1. Remove existing protobuf compiler
```bash
sudo apt-get remove -y protobuf-compiler
```


# 2. Download the latest protobuf release`:

```
wget https://github.com/protocolbuffers/protobuf/releases/download/v30.0-rc1/protoc-30.0-rc-1-linux-x86_64.zip

```

# 3. Unzip the downloaded file to /usr/local/:
```
sudo apt update && sudo apt install -y unzip
```
```
sudo unzip protoc-30.0-rc-1-linux-x86_64.zip -d /usr/local/
```

# 4. Give execute permissions to protoc:

```
sudo chmod +x /usr/local/bin/protoc
```
```
   cd nexus-cli
```
```
source $HOME/.cargo/env
```
# 5. Install the Nexus CLI


```
curl https://cli.nexus.xyz/ | sh
```









