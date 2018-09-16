# make-local-repo
make-local-repo用来创建rpm的本地软件仓库。成功创建本地软件仓库后，就可以离线安装相应的软件包。<br>
使用方法：<br>
　　步骤一：根据需要修改rpms.list文件，在此文件中指定所需下载的软件包名称。现有的rpms.list列出了安装OpenStack的Ocata版本所需的软件包。<br>
　　步骤二：给文件main.sh和entry.sh添加可执行属性：chmod +x main.sh entry.sh<br>
　　步骤三：执行文件main.sh：./main.sh<br>