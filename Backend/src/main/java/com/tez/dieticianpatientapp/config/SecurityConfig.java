package com.tez.dieticianpatientapp.config;

import com.tez.dieticianpatientapp.security.AuthenticationFilter;
import com.tez.dieticianpatientapp.security.JwtAuthenticationEntryPoint;
import com.tez.dieticianpatientapp.service.UserDetailService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    private static final String[] WHITE_LIST_URL = {
            // -- Swagger UI v2
            "/v2/api-docs",
            "/swagger-resources",
            "/swagger-resources/**",
            "/configuration/ui",
            "/configuration/security",
            "/swagger-ui.html",
            "/webjars/**",
            // -- Swagger UI v3 (OpenAPI)
            "/v3/api-docs/**",
            "/swagger-ui/**",
            "/api/v1/login/**",
            "/api/v1/register/**",
            "/h2/**",
            "/swagger-ui.html",
            // other public endpoints of your API may be appended to this array
    };
    private final AuthenticationFilter jwtAuthFilter;

    private final UserDetailService userService;

    private final PasswordEncoder passwordEncoder;

    private final JwtAuthenticationEntryPoint handler;


    public SecurityConfig(AuthenticationFilter jwtAuthFilter, UserDetailService userService, PasswordEncoder passwordEncoder,
                          JwtAuthenticationEntryPoint handler
    ) {
        this.jwtAuthFilter = jwtAuthFilter;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.handler = handler;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        http.authorizeHttpRequests(x ->
                x.requestMatchers(WHITE_LIST_URL).permitAll()
        );
        http.authorizeHttpRequests(x ->
                x.anyRequest().authenticated()
        );

        http.httpBasic(httpBasic -> httpBasic.authenticationEntryPoint(handler));

        http.csrf(AbstractHttpConfigurer::disable);
        http.headers(AbstractHttpConfigurer::disable);

        http.addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }


    @Bean
    public AuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
        authenticationProvider.setUserDetailsService(userService);
        authenticationProvider.setPasswordEncoder(passwordEncoder);
        return authenticationProvider;
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration configuration) throws Exception {
        return configuration.getAuthenticationManager();

    }
}