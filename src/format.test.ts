import {describe,it,expect} from 'vitest'
import {date,initials,age} from './format'
describe('Imported dates',()=>{
 it('does not reinterpret missing legacy dates as real birthdays',()=>{expect(date('0000-00-00')).toBe('Не указана');expect(age('0000-00-00')).toBe('')})
 it('keeps the stored calendar day without timezone conversion',()=>{expect(date('2026-10-13 00:03:12')).toBe('13.10.2026')})
 it('handles initials without assuming a full name',()=>{expect(initials('Иванов')).toBe('И');expect(initials('')).toBe('')})
})
