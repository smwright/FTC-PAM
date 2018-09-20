package pam.sql

import java.io.Serializable
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id
import javax.persistence.MappedSuperclass

@MappedSuperclass
abstract class BaseEntity : Serializable {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  var id: Int = 0
}