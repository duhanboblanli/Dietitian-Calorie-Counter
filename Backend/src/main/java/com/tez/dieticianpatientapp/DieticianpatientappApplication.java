package com.tez.dieticianpatientapp;

import com.tez.dieticianpatientapp.utils.UserType;
import com.tez.dieticianpatientapp.entities.Dietician;
import com.tez.dieticianpatientapp.entities.User;
import com.tez.dieticianpatientapp.repository.DieticianRepository;
import com.tez.dieticianpatientapp.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DieticianpatientappApplication implements CommandLineRunner {

	public static void main(String[] args) {
		SpringApplication.run(DieticianpatientappApplication.class, args);
	}

	@Autowired
	DieticianRepository repository;

	@Autowired
	UserRepository userRepository;

	@Override
	public void run(String... args) throws Exception {
		/*User user = new User("16412473975","password", UserType.Dietician);
		Dietician dietician = new Dietician("adme","soydan",user);

		User user2 = new User("16412473976","password", UserType.Dietician);
		Dietician dietician2 = new Dietician("adme","soydan",user);

		repository.save(dietician);
		repository.save(dietician2);*/

	}
}
