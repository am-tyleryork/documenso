import type { ImgHTMLAttributes } from 'react';

import LogoImage from '@documenso/assets/logo.png';

export type LogoProps = ImgHTMLAttributes<HTMLImageElement>;

export const BrandingLogo = (props: LogoProps) => {
  return <img src={LogoImage} alt="Documenso Logo" {...props} />;
};
