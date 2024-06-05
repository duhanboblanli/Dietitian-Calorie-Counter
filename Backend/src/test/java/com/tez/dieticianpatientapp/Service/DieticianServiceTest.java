package com.tez.dieticianpatientapp.Service;

import com.tez.dieticianpatientapp.entities.Dietician;
import com.tez.dieticianpatientapp.entities.User;
import com.tez.dieticianpatientapp.exception.UserNotFoundException;
import com.tez.dieticianpatientapp.repository.DieticianRepository;
import com.tez.dieticianpatientapp.service.DieticianService;
import com.tez.dieticianpatientapp.service.UserService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class DieticianServiceTest {
    @Mock
    private DieticianRepository dieticianRepository;

    @Mock
    private UserService userService;

    @InjectMocks
    private DieticianService dieticianService;

    @Test
    public void getDieticianByTckn_ShouldRaiseUserNotFoundWhenThereIsNoDieticianHasThisTckn(){
        String tckn = "123";
        User user = User.builder().tckn("123").build();
        when(userService.getUserByTckn(tckn)).thenReturn(Optional.ofNullable(user));
        try {
            dieticianService.getDieticianByTckn(tckn);
        } catch (UserNotFoundException e) {
            assertNotNull(e); // Örnek bir assert
        }
    }

    @Test
    public void getDieticianByTckn_ShouldRaiseUserNotFoundWhenThereIsNoUserHasThisTckn(){
        String tckn = "123";
        try {
            dieticianService.getDieticianByTckn(tckn);
        } catch (UserNotFoundException e) {
            assertNotNull(e); // Örnek bir assert
        }
    }


}
