PROCEDURE get_active_mpreport2(p_start_date  DATE,
                                 p_end_date    DATE,
                                 p_mp_codes    cmn.common_tools.tt_string,
                                 p_model_codes cmn.common_tools.tt_string,
                                 p_cur         OUT ref_cursor) IS
  BEGIN
    EXECUTE IMMEDIATE 'delete from CMN.TMP_CODES_PK_INDEXED'; -- clear the tables for future selected?
  
    IF p_mp_codes.count > 0 THEN 
      FOR i IN 1 .. p_mp_codes.count LOOP -- FOR loop
        IF p_mp_codes(i) IS NOT NULL THEN
          INSERT INTO CMN.TMP_CODES_PK_INDEXED -- inserting a new record in tables
            (code)
            SELECT p_mp_codes(i)
              FROM dual -- dual - table with only 1 record
             WHERE NOT EXISTS (SELECT 1 -- condition that the values do not double, checking if such a value already exists
                      FROM CMN.TMP_CODES_PK_INDEXED c
                     WHERE c.code = p_mp_codes(i));
        END IF;
      END LOOP;
    END IF;
  
    OPEN p_cur FOR 
      SELECT mp_code, -- column selection
             serial_number,
             model_code,
             role,
             he_sys_code,
             energy_digits,
             energy_dec_places,
             start_date,
             end_date,
             obis,
             multiplier,
             tariff
        FROM (SELECT distinct mp.code mp_code, -- column selection
                              ma.serial_number,
                              ma.dsr_mam_code model_code,
                              decode(dsc.nature,
                                     0,
                                     'Rozliczeniowy',
                                     1,
                                     'Kontrolny',
                                     2,
                                     'Bilansujący') role,
                              dsc.he_sys_code,
                              NVL(dsc.energy_digits, 0) -
                              NVL(dsc.energy_dec_places, 0) energy_digits,
                              dsc.energy_dec_places,
                              ds.rank,
                              p.start_date,
                              p.end_date,
                              ds.id,
                              ds.obis,
                              ds.multiplier,
                              c.name tariff,
                              rank() over(PARTITION BY mp.id, p.start_date ORDER BY ds.rank, ds.obis) AS rank_obis
                FROM CMN.TMP_CODES_PK_INDEXED tmp -- selecting records that meet the criteria
                JOIN mpr.measurement_points mp
                  ON mp.code = tmp.code
                JOIN mpr.mp_org_struct mos
                  ON mp.id = mos.mp_id
                JOIN adm.organizational_structures os
                  ON os.id = mos.id_org_struct
                JOIN mpr.mp_config_periods p
                  ON p.mepo_id = mp.id
                JOIN mpr.data_supplier_configs dsc
                  ON dsc.mpcp_id = p.id
                JOIN cal.cal_calendars c
                  on dsc.cal_calendar_id = c.id
                JOIN dsr.meter_assets ma
                  ON ma.dsr_dasu_id = dsc.dsr_dasu_id
                JOIN mpr.data_sources ds
                  ON ds.dasuc_id = dsc.id
                JOIN dsr.meter_asset_models mo
                  ON mo.code = ma.dsr_mam_code
              
               WHERE 1 = 1 --(os.code = 'OB' OR (SELECT code FROM adm.organizational_structures os2 WHERE os.fk_organizationalstructure = os2.id) = 'OB')
                 and p.start_date <= p_end_date
                 and p.end_date >= p_start_date
                 AND ds.obis_c = 1
                 AND ds.obis_d = 8)
       WHERE rank_obis = 1
       ORDER BY 1, 8, 3;
  END;