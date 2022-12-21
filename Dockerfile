ARG from

FROM ${from}

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get install -y -q

RUN apt-get update && apt-get install -y apt-utils \
                                         lsb-release \
                                         mesa-utils \
                                         gnupg2 \
                                         net-tools \
                                         build-essential \
                                         wget \
                                         unzip \
                                         curl \
                                         git \
                                         mc \
                                         vim \
                                         gedit

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 && \
    apt-get update && DEBIAN_FRONTEND=noninteractive \
        apt-get install -y ros-noetic-desktop-full \
            ros-noetic-moveit \
            gazebo11 \
            gazebo11-plugin-base \
            ros-noetic-gazebo-dev \
            ros-noetic-gazebo-plugins \
            ros-noetic-gazebo-ros \
            ros-noetic-gazebo-ros-pkgs \
            ros-noetic-ros-control \
            ros-noetic-gazebo-ros-control \
            ros-noetic-geographic-info \
            ros-noetic-teleop-twist-keyboard \
            ros-noetic-joy \
            ros-noetic-effort-controllers \
            ros-noetic-controller-manager \
            ros-noetic-tf2-sensor-msgs \
            ros-noetic-openslam-gmapping \
            ros-noetic-urdf-sim-tutorial \
            libsdl-image1.2-dev \
            libsdl-dev \
            python3-rosdep \
            python3-rosinstall \
            python3-rosinstall-generator \
            python3-wstool \
            python3-catkin-tools \
            libcanberra-gtk-module \
            libcanberra-gtk3-module \
            ros-noetic-pid \
            ros-noetic-rosserial-arduino \
            ros-noetic-rosserial \
            ros-noetic-moveit-planners-chomp \
            ros-noetic-catkin python3-catkin-tools \
            ros-noetic-moveit-visual-tools \
            ros-noetic-rosbridge-server \
            ros-noetic-rosparam-shortcuts \
            ros-noetic-ros-industrial-cmake-boilerplate \
            ros-noetic-visp* && \
    rosdep init && rosdep update && \
    echo "source /opt/ros/noetic/setup.bash"  >> ~/.bashrc && \
    echo "source /workspace/devel/setup.bash"  >> ~/.bashrc

RUN apt-get install -y python3-pip
RUN pip install pathlib statistics scipy

RUN apt-get install ros-noetic-joint-state-publisher-gui
RUN apt-get install ros-noetic-franka-description
RUN apt-get install ros-noetic*joint-trajectory-controller*