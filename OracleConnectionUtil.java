package jdbc.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class OracleConnectionUtil {

	public static Connection connect() {  //Connection 인터페이스 : 사용할 데이터베이스에 따라 드라이버 클래스가 달라지고
											//   그에 따라 구현클래스(객체) 가 다릅니다.
										 // sql 실행을 위해 가장 먼저 필요한것이 Connection 객체입니다.
		Connection conn = null;

		String url = "jdbc:oracle:thin:@localhost:1521:XE";   //데이터베이스 URL - 디비버에서 확인가능합니다.
					//jdbc프로토콜,오라클 지정 ,localhost는 서버에 접속시 ip로 대체 , 1521은 오라클의 포트
		String driver="oracle.jdbc.driver.OracleDriver";     //오라클 드라이버클래스(패키지명.클래스명)
		String user ="c##idev";				//접속할 계정 정보 - 계정이름
		String password="1234";				//            ㄴ 패스워드
		
		try {
			//메모리에 데이터베이스 드라이버를 로드합니다.(로드-> 적재)
			Class.forName(driver);
			
	//DriverManager 클래스는 메모리에 로드된 드라이버 클래스를 관리하고		
	//DriverManager 클래스의 메소드 getConnection 으로 데이터베이스(오라클) 드라이버에 대한 Connection 구현객체를 생성
	//                                                 			ㄴ    인터페이스 Connection 타입으로 참조합니다.
			conn = DriverManager.getConnection(url,user,password);    //db 연결에 필요한 정보 인자로 전달
			
			
			
		} catch (ClassNotFoundException e) {
			System.out.println("데이터베이스 드라이버 로드에 문제가 생겼습니다. : " + e.getMessage());
		} catch (SQLException e) {
			System.out.println("데이터베이스 연결 및 사용에 문제가 생겼습니다. : " + e.getMessage());
		} 
		
		return conn;   //생성된 Connection 객체 리턴합니다.
	}

	public static void close(Connection conn,PreparedStatement pstmt) {
			try {
				if(conn !=null) conn.close();
				if(pstmt !=null) pstmt.close();
			} catch (SQLException e) {
				System.out.println("데이터베이스 연결 종료에 오류 발생! : " + e.getMessage());
			}
	}
	
}
