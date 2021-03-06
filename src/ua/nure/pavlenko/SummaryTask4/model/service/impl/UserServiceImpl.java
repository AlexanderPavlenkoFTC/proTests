package ua.nure.pavlenko.SummaryTask4.model.service.impl;


import ua.nure.pavlenko.SummaryTask4.exception.*;
import ua.nure.pavlenko.SummaryTask4.model.dao.DaoFactory;
import ua.nure.pavlenko.SummaryTask4.model.dao.api.Dao;
import ua.nure.pavlenko.SummaryTask4.model.dao.impl.UserDaoImpl;
import ua.nure.pavlenko.SummaryTask4.model.dto.UserDto;

import ua.nure.pavlenko.SummaryTask4.model.entity.User;
import ua.nure.pavlenko.SummaryTask4.model.service.api.Service;
import ua.nure.pavlenko.SummaryTask4.utils.mapper.BeanMapper;

import java.util.List;

/**
 * Created by Alexander on 23.05.2017.
 */
public class UserServiceImpl implements Service<User> {
    private static UserServiceImpl service;
    private Dao<User> userDao;
    private BeanMapper beanMapper;

    private UserServiceImpl() {
        userDao = DaoFactory.getInstance().getUserDao();
        beanMapper = BeanMapper.getInstance();
    }

    public static synchronized UserServiceImpl getInstance() {
        if (service == null) {
            service = new UserServiceImpl();
        }
        return service;
    }


    @Override
    public List<User> getAll() {
        List<User> list = userDao.getAll();
        return list;
    }

    @Override
    public User getById(Integer id) {
        User user = userDao.getById(id);
        return user;
    }

    @Override
    public User save(User entity) throws AppException {
        return null;
    }

    @Override
    public void delete(Integer key) {

    }

    @Override
    public void update(User entity){
        try {
            userDao.update(entity);
        } catch (AppException e) {
            SuppressedException suppressedException = new SuppressedException();
            suppressedException.addSuppressed(new UniqueException(Massages.INFORM_LOGIN_BUSY + " or " + Massages.INFORM_EMAIL_BUSY));
            throw new SuppressedException();
        }
    }


    public UserDto save(String password, String login, String name, String e_mail) throws AppException {
        if (password.length() < 6) {
            throw new ValidationException(Massages.ERR_SHORT_PASSWORD);
        }
        if (!name.contains(" ")) {
            throw new ValidationException(Massages.ERR_UNCORRECTED_NAME);
        }
        User user = new User();
        user.setE_mail(e_mail);
        user.setLogin(login);
        user.setPassword(password);
        user.parseName(name);
        userDao.save(user);

        UserDto userDto = beanMapper.singleMapper(user, UserDto.class);

        return userDto;
    }

    public UserDto login(String login, String password) throws ObjectNotExist, InvalidatePassword {
        UserDto userDto = findUserByLogin(login);
        if (!confirmPassword(userDto, password)) {
            throw new InvalidatePassword(Massages.INFORM_INVALIDATE_PASSWORD);
        }
        return userDto;

    }

    private boolean confirmPassword(UserDto userDto, String password) {
        return userDao.getById(userDto.getId()).getPassword().equals(password);
    }

    private UserDto findUserByLogin(String login) throws ObjectNotExist {
        User user = ((UserDaoImpl) userDao).findUserByLogin(login);
        UserDto userDto = beanMapper.singleMapper(user, UserDto.class);
        return userDto;

    }

    public boolean isFreeLogin(String login) {
        try {
            findUserByLogin(login);
        } catch (ObjectNotExist userNotExist) {
            return true;
        }
        return false;

    }


}
