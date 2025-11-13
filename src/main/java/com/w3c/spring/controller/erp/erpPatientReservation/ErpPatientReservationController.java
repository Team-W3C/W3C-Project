package com.w3c.spring.controller.erp.erpPatientReservation;

import com.w3c.spring.model.vo.ReservationDetailVO;
import com.w3c.spring.service.reservation.ReservationService;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/erp/erpReservation")
public class ErpPatientReservationController {
    private final ReservationService reservationService;

    public ErpPatientReservationController(ReservationService reservationService) {
        this.reservationService = reservationService;
    }
    @GetMapping("/reservation")
    public String enterErp() {
        return "erp/patientReservation/reservation";
    }

    @GetMapping("/getReservations")
    @ResponseBody
    public Map<String, List<ReservationDetailVO>> selectReservationDetailByDate(@RequestParam String selectedDate) {
        System.out.println("선택 날짜: " + selectedDate);
        return reservationService.selectReservationDetailByDate(selectedDate);
    }

    @PostMapping("/updateStatus")
    @ResponseBody
    public int updateRvtnStatus(
            @RequestParam("reservationNo") int reservationNo,
            @RequestParam("status") String status) {

        return reservationService.updateRvtnStatus(status,reservationNo);
    }

    @GetMapping("/detail/{reservationNo}")
    @ResponseBody
    public ReservationDetailVO selectRvtnDetail(@PathVariable("reservationNo") int reservationNo){
        return reservationService.selectRvtnDetail(reservationNo);
    }
}


