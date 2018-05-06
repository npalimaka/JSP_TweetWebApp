package com.sdacademy.twitter.model;

import lombok.*;

import javax.persistence.*;
import java.util.Set;

/**
 * Class holds tweets of the user
 */
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "tweets")
public class Tweet implements BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NonNull
    @Column(nullable = false)
    private String message;

    @ManyToOne(cascade = CascadeType.PERSIST, fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

//    @Transient
//    private Tweet reTweet;

    @NonNull
    private Long creationTS;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "tweet", cascade = CascadeType.ALL)
    private Set<Comment> comments;
}
