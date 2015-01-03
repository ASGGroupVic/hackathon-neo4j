node 'vagrant.vm' {
    include 'docker'

    docker::image { 'ubuntu':
        image_tag => 'precise'
    }

    docker::image { 'tpires/neo4j':
    }

    docker::run { 'neo4j':
      image => 'tpires/neo4j',
      ports => '7474:7474',
      use_name => true,
      privileged => true,
      restart_service => true,

    }
}