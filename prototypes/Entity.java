package {{PACKAGE}};

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

@Entity
@Table(name = "")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class {{CLASS_NAME}} {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
}
