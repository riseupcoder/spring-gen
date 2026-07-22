package {{PACKAGE}};

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface {{CLASS_NAME}} extends JpaRepository<{{ENTITY}}, UUID> {

}

