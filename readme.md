# Intranet Mail Server Setup

This repository contains the necessary files to deploy an intranet-only mail server using Docker Compose. This setup is designed to be accessible only within your internal network or via a VPN connection and is **not exposed to the public internet**.

## What's Going On?

This repository includes the following files:

* **`compose.yaml`**: This is the Docker Compose file that defines the `intranet-mail-server` service. It specifies the Docker image to use (`mailserver/docker-mailserver`), container name, restart policy, hostname, domain name, port mappings, environment variables, and volume mounts.
* **`compose.bash`**: This is a bash script that automates the deployment of the mail server using Docker Compose. It pulls the Docker image, stops and removes any existing containers, and starts the new container.
* **`configure.bash`**: This script handles the initial configuration of the mail server, including creating necessary directories, setting permissions, and adding initial mail accounts.

The `intranet-mail-server` service utilizes the `mailserver/docker-mailserver` image, a well-known and robust Docker image for setting up a full-fledged mail server.

The `compose.bash` script simplifies the Docker Compose workflow, while the `configure.bash` script handles the setup of the persistent volumes and initial user accounts.

## What It Does

This setup deploys a basic email server intended for internal network use. It allows users within the intranet (or connected via VPN) to send and receive emails. The configuration focuses on simplicity by disabling several security and filtering features.

**Key Features:**

* **Intranet-Only Access:** The mail server is explicitly configured in the `compose.yaml` to listen on specific internal IP addresses (`127.0.0.1` for local access and `10.28.1.1` for network access), making it inaccessible from the public internet.
* **Basic Mail Functionality:** Provides SMTP (sending), IMAP/POP3 (receiving) services.
* **Persistent Storage:** Mail data, server state, logs, and configuration are stored in local volumes on the host machine as defined in `compose.yaml`.
* **Pre-configured Accounts:** The `configure.bash` script automatically creates two initial mail accounts.

## How to Use

1.  **Clone the Repository:** Clone this Git repository to your local machine.
2.  **Navigate to the Directory:** Open your terminal and navigate to the cloned repository directory.
3.  **Run the Configuration Script:** Execute the `configure.bash` script to set up the necessary directories and initial mail accounts:
    ```bash
    chmod +x configure.bash
    ./configure.bash
    ```
    You might be prompted for your `sudo` password as this script creates directories and changes ownership.
4.  **Run the Deployment Script:** Execute the `compose.bash` script to deploy the mail server using Docker Compose:
    ```bash
    chmod +x compose.bash
    ./compose.bash
    ```
5.  **Access the Mail Server:** Users on your internal network (or connected via VPN) can configure their email clients using the following protocols and ports with the IP address of your server (`10.28.1.1`):
    * **SMTP (Sending):** Port `587`
    * **IMAP (Receiving):** Port `143` or `993` (for secure IMAP over TLS)
    * **POP3 (Receiving):** Not explicitly configured in the default ports, but the image likely supports it on standard ports if needed.
6.  **Mail Account Credentials:** The initial email accounts and passwords created are:
    * **wordpress@shinobinet.online:** `embanet`
    * **shinobi@shinobinet.online:** `embanet`

## Important Information

* **Intranet Security:** This mail server is designed for internal use only. It relies on the security of your internal network and VPN for protection. **The mail server is not accessible to the world.**
* **Limited Features:** Several features like spam filtering, antivirus, and intrusion prevention are disabled in this configuration. Consider enabling them if your internal security requirements necessitate it.
* **Mail Server Management:** For adding more mail accounts, managing aliases, and other administrative tasks, you will need to consult the documentation for the `mailserver/docker-mailserver` image. You might need to modify the configuration files in the `/tmp/volume/intranet/email/config/` directory and restart the Docker container using `docker compose restart intranet-mail-server`.
* **Host IP Address:** Ensure that the IP address `10.28.1.1` in the `compose.yaml` file is the correct internal IP address of the machine hosting this mail server. If it's different, update the port mappings accordingly. The `127.0.0.1` mappings are for local access on the server itself.
* **Mail Data Location:** The actual mail data for each user will be stored in the `/tmp/volume/intranet/email/data/` directory on the host machine.
* **Key Ports Only:** This configuration explicitly binds the mail server to the standard, key ports (`25`, `143`, `587`, `993`) on the specified internal IP addresses. This further reinforces the intranet-only nature of the deployment.

## Firewall Rules

Since this mail server is intended for intranet use only and is accessed via VPN, you should ensure that your **internal firewall** allows traffic on the following ports **from your internal network and VPN clients to the IP address of the mail server (`10.28.1.1`)**:

* **TCP Port 25:** SMTP (for sending emails between mail servers within the intranet, if applicable)
* **TCP Port 143:** IMAP (for receiving emails)
* **TCP Port 587:** Submission (for authenticated email sending from clients)
* **TCP Port 993:** IMAP over TLS/SSL (for secure email receiving)

**Important Considerations:**

* **No Public Access:** Do **NOT** open these ports to the public internet on your external firewall. This mail server is not configured or intended for direct public access.
* **VPN Security:** Ensure your VPN connection is properly secured to prevent unauthorized access to your internal network.
* **Internal Network Segmentation:** Consider network segmentation to further isolate the mail server within your internal network.

This setup provides a basic intranet mail server. For more advanced configurations and security measures, refer to the documentation of the `mailserver/docker-mailserver` image.
