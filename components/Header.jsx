import Image from "next/image";
import dtiiLogo from "../public/assets/Icon_logo.svg";
import userPhoto from "../public/assets/person_logo.svg";
const Header = () => {
  return (
    <header className="header-container">
      <div className="flex-item-center gap-10">
        <Image alt="dtii logo" src={dtiiLogo} height={30} width={30} />
        <div className="heading">
          <span>Ascert.en</span>
          <span>Back Office</span>
        </div>
      </div>
      <div className="flex-item-center gap-10">
        <Image src={userPhoto} alt="user photo" />
        <div className="heading">
          <span>John Doe</span>
          <span>Admin</span>
        </div>
      </div>
    </header>
  );
};

export default Header;
