package pam.util

import java.io.Serializable

data class Sort(
        val name: String,
        val direction: Direction?
) : Serializable {


    enum class Direction {
        ASC,
        DESC
    }
}