//package com.capsule.youkids.user.service;
//
////import com.capsule.youkids.user.entity.User;
//import com.capsule.youkids.user.entity.User;
//import com.capsule.youkids.user.repository.UserRepository;
//import lombok.RequiredArgsConstructor;
//import org.springframework.security.core.GrantedAuthority;
//import org.springframework.security.core.authority.SimpleGrantedAuthority;
//import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.security.core.userdetails.UserDetailsService;
//import org.springframework.security.core.userdetails.UsernameNotFoundException;
//import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
//import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
//import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
//import org.springframework.security.oauth2.core.user.OAuth2User;
//import org.springframework.stereotype.Service;
//
//import java.util.Collections;
//import java.util.UUID;
//
//@RequiredArgsConstructor
//@Service
//public class PrincipalService extends DefaultOAuth2UserService {
//
//    private final UserRepository userRepository;
//
//    @Override
//    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
//
//        OAuth2User oAuth2User = super.loadUser(userRequest);
//
//        System.out.println("oAuth2User.getAttributes() = "+ oAuth2User.getAttributes());
//
//        String provider = userRequest.getClientRegistration().getClientId();
//        String providerId = oAuth2User.getAttribute("sub");
//        String email = oAuth2User.getAttribute("email");
//        String role = "ROLE_USER";
//
//        User userEntity = userRepository.findByEmail(email);
//
//        if(userEntity == null){
//
//            userEntity = User.builder()
//                    .userId(UUID.randomUUID())
//                    .email(email)
//                    .providerId(providerId)
//                    .provider(provider)
//                    .build();
//
//            userRepository.save(userEntity);
//
//        }
//
//        return new PrincipalDetails(userEntity, oAuth2User.getAttributes());
//
//
//
//    }
//
//
//
////    @Override
////    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
////
////        User findUser = userRepository.findByEmail(email).orElseThrow(()->new IllegalArgumentException());
////
////        return new PrincipalDetails(findUser);
////
////
////    }
//
//}
