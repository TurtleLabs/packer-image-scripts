# Cloudspace DevOps -- Packer

The repo contains Clousdpace's scripts & configs to build client VMs (vagrant, AMIs, VMWare, etc.) with Packer.io.  It also conains initial Capistrano deploy setups, a dev environment Vagrantfile, and scrips to configure a new OS X dev machine and setup individual projects.


## Configuring a new computer

####  NOTE:  This is not for the first time using packer on your computer.  This is literally for a newly purchased computer that needs to be provisioned.  It will install/upgrade Xcode command line tools, virtualbox, etc.

0. Install XCode from the Mac App Store; and start Xcode so you can accept the terms & conditions before moving on
1. Run the following script in terminal on your computer:
`bash <(curl -s https://raw.githubusercontent.com/cloudspace-devops/packer-image-scripts/master/osx-dev-machine-setup.sh)`
2. When prompted, select "Install" to get the command line developer tools.  After the install completes, dismiss the dialogue and press [return] in terminal.
3. Enter your system password when prompted to install Brew
4. Enter your full name and password for git when prompted.
5. If prompted, enter your system password to create a /srv folder for development.
6. If prompted, press enter to use the defaults three times to generate your id_rsa key.


## Building Packer Images

1. Set your AWS key/secret as an environment variable

    ```
    export AWS_ACCESS_KEY_ID="xxxxxxxxx"
    export AWS_SECRET_ACCESS_KEY="xxxxxxx
    ```

2. Create all base images

    ```
    ./build-all.sh
    ```

3. Run the desired individual build script

    ```
    packer build build-name.json
    ```

4. To create a custom project box, copy the closest match into the packer-projects folder, update the base image source, add/create the appropriate shell script(s), and run the build.

# Launching AWS Boxes

1. Login to the EC2 console with your Amazon IAM account using the IAM login for your client.  (For cloudspace use https://cloudspace.signin.aws.amazon.com/console) If you don't have an Amazon IAM user setup, request one from DevOps.
2. Click "EC2"
3. Click "Launch Instance"
4. Find the AMI for your project in my amis or community amis.  If you are sure you can use ami-c8cf3ba0.
5. Scroll down, select instance size (m1.small is a good start, then move to c3.large as needed) and click "Next: Configure Instance Details"
6. Normally you can just leave the defaults and click "Next: Add Storage."  If you need to set any keys or system jobs, especially with CoreOS, use cloud-init in the User Data field under Advanced Details.  See http://cloudinit.readthedocs.org/en/latest/topics/examples.html for more information.
7. Select your storage site (usually 8GB to start) & volume type (General Purpose SSD is the same price as Magnetic so you should usually select GPSSD), and click "Next: Tag Instance."
8. Name your instance and click "Next: Configure Security Group"
9. Create or select your security group.  For most Cloudspace projects, select the existing "default" group. Click "Review and Launch."
10. Scroll down and click "Launch."
11. Choose an existing keypair or make a new one.  For most Cloudspace projects, select the "ops" key pair and check the box acknowledging you have access to the key.
12. Click "Launch Instances."
13. Scroll down and click "View Instances."
14. Grab the public ip of your launched container and toss that in the .env file under the environment you are setting up.
