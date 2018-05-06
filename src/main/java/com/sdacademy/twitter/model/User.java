package com.sdacademy.twitter.model;

import lombok.*;

import javax.persistence.*;
import java.util.Set;

/**
 * This class is responsible for handling user data.
 */
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "users")
public class User implements BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NonNull
    @Column(unique = true)
    private String nick;

    @NonNull
    @Column(nullable = false)
    private String email;

    @NonNull
    @Column(nullable = false)
    private String password;

    @NonNull
    @Column(nullable = false)
    private Long creationTS;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "author", cascade = CascadeType.REMOVE)
    private Set<Comment> comments;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user", cascade = CascadeType.REMOVE)
    private Set<Tweet> tweets;
}
